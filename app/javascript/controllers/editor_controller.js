import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['content_editor']

  connect() {
    tinymce.init({
      selector: '.tinymce',
      promotion: false,
    });


    console.log("Editor connected")
  }
}