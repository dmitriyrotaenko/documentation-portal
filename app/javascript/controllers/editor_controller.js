import { Controller } from "@hotwired/stimulus"
import Highlight from "highlight.js"

import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'

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
    const editorContent = this.contentEditor.getHTML()
    const dataToSave = editorContent === "" ? "<p></p>" : editorContent;
    const hiddenContentField = this.page_content_hiddenTarget;

    hiddenContentField.value = dataToSave;

    pageForm.submit();
  }

  getPageCurrentContent() {
    return this.page_content_hiddenTarget.value;
  }
}