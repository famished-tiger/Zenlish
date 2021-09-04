# frozen_string_literal: true

require_relative '../lex/literal'

module Zenlish
  module Lexer
    class Lexer
      # @return [StringScanner] Low-level scanner object.
      attr_reader(:scanner)

      # @return [Boolean] true, if lexer is currently busy to scan Zenlish.
      attr_reader(:zenlish_mode)

      # @return [Integer] Current line number (one-based)
      attr_reader(:lineno)

      # @return [Integer] Offset of start of current line within IO (one-based).
      attr_reader(:line_start)

      @@punct2name = {
        ':' => 'Colon',
        ',' => 'Comma',
        '.' => 'Period',
        '"' => 'Quote'
      }.freeze

      class ScanError < StandardError; end

      # Constructor. Initialize a tokenizer for Skeem.
      # @param source [String] Skeem text to tokenize.
      def initialize(source)
        @scanner = StringScanner.new('')
        @zenlish_mode = true
        reinitialize(source)
      end

      # @param source [String] Skeem text to tokenize.
      def reinitialize(source)
        @scanner.string = source
        @lineno = 1
        @line_start = 0
      end

      # @return [Array<Token>] | Returns a sequence of tokens
      def tokens
        tok_sequence = []
        until @scanner.eos?
          token = _next_token
          tok_sequence << token unless token.nil?
        end

        return tok_sequence
      end

      private

      def _next_token
        skip_intertoken_spaces
        if zenlish_mode
          next_zenlish_token
        else
          next_json_token
        end
      end

      def next_zenlish_token
        curr_ch = scanner.peek(1)
        return nil if curr_ch.nil? || curr_ch.empty?

        token = nil

        if ':,."'.include? curr_ch
          # Delimiters, separators => single character token
          token = build_token(@@punct2name[curr_ch], scanner.getch)
        elsif (literal = scanner.scan(/[^\s:;,."]+/))
          token = build_token('WORD', literal)
        else # Unknown token
          erroneous = curr_ch.nil? ? '' : scanner.scan(/./)
          sequel = scanner.scan(/.{1,20}/)
          erroneous += sequel unless sequel.nil?
          raise ScanError, "Unknown token #{erroneous} on line #{lineno}"
        end

        return token
      end

      def build_token(aSymbolName, aLiteral, _format = :default)
        begin
          col = scanner.pos - aLiteral.size - @line_start + 1
          pos = Rley::Lexical::Position.new(@lineno, col)
          token = Rley::Lexical::Token.new(aLiteral, aSymbolName, pos)
        rescue StandardError => e
          puts "Failing with '#{aSymbolName}' and '#{aLiteral}'"
          raise e
        end

        return token
      end

      def next_json_token
        curr_ch = scanner.peek(1)
        return nil if curr_ch.nil? || curr_ch.empty?

        token = nil

        if ':,."'.include? curr_ch
          # Delimiters, separators => single character token
          token = build_token(@@punct2name[curr_ch], scanner.getch)
        elsif (literal = scanner.scan(/[^\s:;,."]+/))
          token = build_token('WORD', literal)
        else # Unknown token
          erroneous = curr_ch.nil? ? '' : scanner.scan(/./)
          sequel = scanner.scan(/.{1,20}/)
          erroneous += sequel unless sequel.nil?
          raise ScanError, "Unknown token #{erroneous} on line #{lineno}"
        end

        return token
      end

      def skip_intertoken_spaces
        pre_pos = scanner.pos

        loop do
          ws_found = scanner.skip(/[ \t\f]+/) ? true : false
          nl_found = scanner.skip(/(?:\r\n)|\r|\n/)
          if nl_found
            ws_found = true
            next_line
          end
          break unless ws_found
        end

        curr_pos = scanner.pos
        return if curr_pos == pre_pos
      end

      def next_line
        @lineno += 1
        @line_start = scanner.pos
      end
    end # class
  end # module
end # module
