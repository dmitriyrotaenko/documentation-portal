import { Controller } from "@hotwired/stimulus";
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";
import { Image } from "@tiptap/extension-image";
import { Dropcursor } from "@tiptap/extension-dropcursor";



export default class extends Controller {
  static targets = ['content_editor']

  connect() {
    this.editor = new Editor({
      element: this.content_editorTarget,
      extensions: [
        StarterKit,
        Image
      ],
      editorProps: {
        attributes: {
          class: 'prose prose-sm sm:prose lg:prose-lg xl:prose-2xl mx-auto focus:outline-none',
        },
      },
      content: '<img src="https://images.unsplash.com/photo-1682686581264-c47e25e61d95?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"/>'
    });
  }
}