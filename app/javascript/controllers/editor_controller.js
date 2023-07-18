import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['content_editor']

  connect() {
    tinymce.init({
      selector: ".tinymce",
      promotion: false,
      toolbar: 'fullscreen',
      plugins: 'fullscreen'
    });
  }

  saveEditorData(event) {
    // event.preventDefault();
    // const pageForm = this.element
    // const editorContent = this.contentEditor.getHTML()
    // const dataToSave = editorContent === "" ? "<p></p>" : editorContent;
    // const hiddenContentField = this.page_content_hiddenTarget;
    //
    // hiddenContentField.value = dataToSave;
    //
    // pageForm.submit();
  }

  getPageCurrentContent() {
    // return this.page_content_hiddenTarget.value;
  }
}