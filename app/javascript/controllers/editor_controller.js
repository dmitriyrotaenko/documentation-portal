import { Controller } from "@hotwired/stimulus";
import { Editor } from "@tiptap/core";
import StarterKit from "@tiptap/starter-kit";
import { Image as I} from "@tiptap/extension-image";
import {Dropcursor} from "@tiptap/extension-dropcursor";
import axios from "axios";



export default class extends Controller {
  static targets = ['content_editor']

  connect() {
    this.editor = new Editor({
      element: this.content_editorTarget,
      extensions: [
        StarterKit,
        I
      ],
      editorProps: {
        handleDrop: (view, event, slice, moved) => {
          if (!moved && event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files[0]) { // if dropping external files
            let file = event.dataTransfer.files[0]; // the dropped file
            let filesize = ((file.size/1024)/1024).toFixed(4); // get the filesize in MB
            if ((file.type === "image/jpeg" || file.type === "image/png") && filesize < 10) { // check valid image type under 10MB
              // check the dimensions
              let _URL = window.URL || window.webkitURL;
              let img = new Image; /* global Image */
              img.src = _URL.createObjectURL(file);
              img.onload = () => {
                if (this.width > 5000 || this.height > 5000) {
                  window.alert("Your images need to be less than 5000 pixels in height and width."); // display alert
                } else {
                  // valid image so upload to server
                  // uploadImage will be your function to upload the image to the server or s3 bucket somewhere
                  this.uploadFiles(file).then(function(response) { // response is the image url for where it has been saved
                    // do something with the response
                  }).catch(function(error) {
                    if (error) {
                      window.alert("There was a problem uploading your image, please try again.");
                    }
                  });
                }
              };
            } else {
              window.alert("Images need to be in jpg or png format and less than 10mb in size.");
            }
            return true; // handled
          }
          return false; // not handled use default behaviour
        },
        attributes: {
          class: 'prose prose-sm sm:prose lg:prose-lg xl:prose-2xl mx-auto focus:outline-none',
        },
      }
    });
  }

  async uploadFiles(file) {
    console.log('ha')
    const formData = new FormData();
    formData.append("upload[file]", file);

    axios
      .post("/uploads", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      .then((response) => {
        const imageUrl = response.data.url;
        this.insertImage(imageUrl);
      })
      .catch((error) => {
        console.error(error);
        // Handle the error, e.g., show an error message to the user.
      });
  }

  insertImage(url) {
    const range = this.editor.view.state.selection.$from;
    const node = this.editor.schema.nodes.image.create({ src: url });
    const transaction = this.editor.view.state.tr.insert(range.pos, node);
    this.editor.view.dispatch(transaction);
  }
}