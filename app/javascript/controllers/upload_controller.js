import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";

const AVAILABLE_IMAGE_TYPES = ["image/jpeg", "image/png"];
const FILE_SIZE_LIMIT = 10;
const DIRECT_UPLOAD_URL = "/rails/active_storage/direct_uploads";

export default class extends Controller {
  handleDrop(event, editorController) {
    const file = event.dataTransfer.files[0];
    const fileSizeMB = ((file.size / 1024) / 1024).toFixed(4);

    if (this.isFileValid(file.type, fileSizeMB)) {
      const URL = window.URL || window.webkitURL;
      const img = new Image();
      img.src = URL.createObjectURL(file);
      img.onload = async () => {
        const { schema } = editorController.editor.state;
        const coordinates = editorController.editor.view.posAtCoords({ left: event.clientX, top: event.clientY });
        try {
          const blob = await this.uploadFile(file);
          this.insertImageNode(editorController.editor.view, schema, coordinates.pos, blob);
        } catch (error) {
          console.log(error);
        }
      };
    } else {
      window.alert("Images need to be in jpg or png format and less than 10mb in size.");
    }
  }

  isFileValid(type, size) {
    return AVAILABLE_IMAGE_TYPES.includes(type) && size <= FILE_SIZE_LIMIT;
  }

  insertImageNode(view, schema, pos, blob) {
    const imageNode = schema.nodes.image.create({
      src: `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`
    });
    view.dispatch(view.state.tr.insert(pos, imageNode));
  }

  async uploadFile(file) {
    return new Promise((resolve, reject) => {
      const upload = new DirectUpload(file, DIRECT_UPLOAD_URL);
      upload.create((error, blob) => {
        if (error) {
          reject(error);
        } else {
          resolve(blob);
        }
      });
    });
  }
}
