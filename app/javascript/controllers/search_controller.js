import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["search_suggestions", "search_field"]
  connect() {
    this.searchBtn = document.getElementById("search_button");
    this.searchModal = document.getElementById("search_modal");
    this.searchModalBackdrop = document.getElementById("search-modal-backdrop");

    this.searchBtn.addEventListener("click", this.openSearchModal.bind(this));
    this.searchModalBackdrop.addEventListener("click", this.closeSearchModal.bind(this));
  }

  openSearchModal() {
    this.searchModal.classList.remove('hidden');
  }

  closeSearchModal({target, currentTarget}) {
    if(target === currentTarget) {
      this.searchModal.classList.add('hidden');
      this.clearSearchField();
    }
    return;
  }

  clearSearchField() {
    this.search_fieldTarget.value = "";
  }

  debouncedSearch() {
    clearTimeout(this.lastRequest);
    this.lastRequest = setTimeout(() => {
      this.search_fieldTarget.form.requestSubmit();
    }, 500);
  }

  disconnect() {
    this.searchBtn.removeEventListener("click", this.toggleSearchModal.bind(this));
    this.searchModalBackdrop.removeEventListener("click", this.toggleSearchModal.bind(this));
  }
}
