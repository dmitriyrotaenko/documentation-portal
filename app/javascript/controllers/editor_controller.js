import { Controller } from "@hotwired/stimulus";
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";
import { Image as TipTapImage } from "@tiptap/extension-image";

export default class extends Controller {
  static targets = ["content_editor"];

  connect() {
    this.editor = new Editor({
      element: this.content_editorTarget,
      // TODO: move to application.yml
      extensions: [StarterKit, TipTapImage],
      editorProps: {
        attributes: {
          class: 'prose prose-sm sm:prose lg:prose-lg xl:prose-2xl mx-auto focus:outline-none',
        },
        handleDrop: (_, event, _, moved) => {
          const uploadController = this.application.getControllerForElementAndIdentifier(
            document.querySelector(".contents"), "upload"
          );
          if (uploadController && !moved && event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files[0]) {
            uploadController.handleDrop(event, this);
            return true;
          }
          return false;
        }
      }
    });
  }
}