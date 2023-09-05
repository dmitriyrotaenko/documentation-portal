import { Controller } from "@hotwired/stimulus";
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";
import { Image as TipTapImage } from "@tiptap/extension-image";

export default class extends Controller {
  static targets = ["content_field"];

  connect() {
    tinymce.init({
      selector: '.tinymce',
      promotion: false,
      plugins: 'link textpattern lists codesample image table fullscreen',
      toolbar: 'undo redo | bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | outdent indent | numlist bullist | link codesample table fullscreen',
      menubar: false
    });

    console.log('Editor controller connected!')

    // this.editor = new Editor({
    //   element: this.content_editorTarget,
    //   // TODO: move to application.yml
    //   extensions: [StarterKit, TipTapImage],
    //   autofocus: true,
    //   content: this.content_fieldTarget.value,
    //   editorProps: {
    //     attributes: {
    //       class: 'prose prose-sm sm:prose lg:prose-lg xl:prose-2xl mx-auto focus:outline-none',
    //     },
    //     // Drag-n-drop upload
    //     handleDrop: (_, event, __, moved) => {
    //       const uploadController = this.application.getControllerForElementAndIdentifier(
    //         document.querySelector(".contents"), "upload"
    //       );
    //       if (uploadController && !moved && event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files[0]) {
    //         uploadController.handleDrop(event, this);
    //         return true;
    //       }
    //       return false;
    //     }
    //   }
    // });
    
    // this.element.addEventListener("submit", this.saveContent.bind(this));
  }

  saveContent(event) {
    event.preventDefault();
    this.content_fieldTarget.value = this.editor.getHTML();
    this.element.submit();
  }

  disconnect() {
    this.element.removeEventListener("submit", this.saveContent.bind(this));
  }
}