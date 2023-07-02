import { Controller } from "@hotwired/stimulus"
import EditorJS from "@editorjs/editorjs";
import Header from "@editorjs/header"
import CodeTool from "@editorjs/code"
import NestedList from "@editorjs/nested-list"
import List from "@editorjs/list"
import Paragraph from "@editorjs/paragraph"
import Undo from 'editorjs-undo';
import Highlight from "highlight.js"

import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'

// Connects to data-controller="editor"
// export default class extends Controller {
//   static targets = ["page_content", "page_content_hidden"]
//   connect() {
//     const pageContent = this.getPageContent();
//
//     this.contentEditor = new EditorJS({
//       holder: this.page_contentTarget,
//       data: pageContent,
//       tools: {
//         header: {
//           class: Header
//         },
//         list: {
//           class: NestedList,
//           inlineToolbar: true,
//         },
//         paragraph: {
//           class: Paragraph,
//           config: {
//             inlineToolbar: true
//           }
//         },
//         code: CodeTool
//       },
//       onReady: () => {
//         new Undo({ contentEditor });
//       },
//     });
//     this.element.addEventListener("submit", this.saveEditorData.bind(this))
//   }
//
//   async saveEditorData(event) {
//     event.preventDefault();
//     const output = await this.contentEditor.save();
//     const pageForm = this.element;
//     const hiddenContentField = this.page_content_hiddenTarget;
//
//     hiddenContentField.value = JSON.stringify(output);
//     pageForm.submit();
//   }
//
//   getPageContent() {
//     const hiddenContentField = this.page_content_hiddenTarget;
//     if (hiddenContentField && hiddenContentField.value) {
//       return JSON.parse(hiddenContentField.value)
//     }
//
//     return {};
//   }
// }


export default class extends Controller {
  static targets = ["markdown", "page_content_hidden"]

  connect() {
    this.contentEditor = new Editor({
      // config to a separate file
      element: this.markdownTarget,
      extensions: [
        StarterKit
      ],
      content: this.getPageCurrentContent(),
      autofocus: true,
      editable: true,
      editorProps: {
        attributes: {
          class: 'prose prose-sm sm:prose-base m-5 focus:outline-none',
        },
      }
    });

    this.element.addEventListener("submit", this.saveEditorData.bind(this));
  }

  saveEditorData(event) {
    event.preventDefault();
    const pageForm = this.element
    const editorOutput = this.contentEditor.getHTML();
    const hiddenContentField = this.page_content_hiddenTarget;

    hiddenContentField.value = editorOutput;

    pageForm.submit();
  }

  getPageCurrentContent() {
    return this.page_content_hiddenTarget.value;
  }
}