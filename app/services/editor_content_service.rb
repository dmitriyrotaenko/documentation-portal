class EditorContentService < ApplicationService
  LIST_TYPES = {
    unordered: "",
    ordered: ""
  }.freeze

  CUSTOM_TYPE_TO_HTML = {
    paragraph: "<p>%{text}</p>",
    header: "<h%{level}>%{text}</h%{level}>",
  }.freeze

  # Content example
  #
  # {
  #    "time": 1550476186479,
  #    "blocks": [
  #       {
  #          "type": "heading",
  #          "data": {
  #             "text": "Editor.js",
  #             "level": 2
  #          }
  #       },
  #       {
  #          "type": "paragraph",
  #          "data": {
  #             "text": "Hey. Meet the new Editor. On this page you can see it in action — try to edit this text. Source code of the page contains the example of connection and configuration."
  #          }
  #       },
  #       {
  #          "type": "heading",
  #          "data": {
  #             "text": "Key features",
  #             "level": 3
  #          }
  #       }
  #    ],
  #    "version": "2.8.1"
  # }

  def call(content)
    parsed_content = JSON.parse(content)

  end
end