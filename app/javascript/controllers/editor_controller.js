import { Controller } from "@hotwired/stimulus";
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";
import { Image } from "@tiptap/extension-image";
import {Dropcursor} from "@tiptap/extension-dropcursor";



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
      }
    });
  }
}