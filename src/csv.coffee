define ['droplet-helper', 'droplet-parser'], (helper, parser) ->
    exports = {}

    exports.CsvParser = class CsvParser extends parser.Parser
      constructor: (@text, @opts = {}) ->
        super
        @lines = @text.split '\n'

      markRoot: ->
        for line, i in @lines

          if line.length isnt 0
            @lineBlock line, i, i, 0, line.length, '#C2D1D1'

            words = line.split ','
            lastWordLen = 0

            for word, j in words
              len = word.length
              @fieldSocket word, i, i, lastWordLen, lastWordLen+word.length
              lastWordLen += word.length+1

      lineBlock: (text, startRow, endRow, startCol, endCol, color)->
        @addBlock {
          bounds: {
            start: {line: startRow, column: startCol} # Lines and columns are zero-indexed
            end: {line: endRow, column: endCol}
          }
          color: color
          classes: text.split ','
        }

      fieldSocket: (text, startRow, endRow, startCol, endCol)->
        @addSocket {
          bounds: {
            start: {line: startRow, column: startCol} # Lines and columns are zero-indexed
            end: {line: endRow, column: endCol}
          }
        }

     return parser.wrapParser CsvParser
