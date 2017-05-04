document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });

  // adding SF places as list items
  const allForms = document.querySelectorAll('form');

  const sfPlaceInput = document.querySelector('.favorite-input');
  const sfPlaceForm = allForms[0];
  const sfPlaceUl = document.querySelector('#sf-places');

  sfPlaceForm.addEventListener("submit", e => {
    e.preventDefault();
    const favLi = document.createElement('li');
    favLi.innerHTML = sfPlaceInput.value;
    sfPlaceUl.appendChild(favLi);
    sfPlaceInput.value = '';
  });


  // adding new photos

  const photoButton = document.querySelector('.photo-show-button');
  const photoForm = document.querySelector('.photo-form-container');

  photoButton.addEventListener('click', () => {
    photoForm.classList.remove('hidden');
  });

  const photoInput = document.querySelector('.photo-url-input');
  const photoSubmit = allForms[1];
  const photoUl = document.querySelector('.dog-photos');

  photoSubmit.addEventListener('submit', e => {
    e.preventDefault();
    const photoLi = document.createElement('li');
    const photoImg = document.createElement('img');
    photoImg.setAttribute('src', photoInput.value);
    photoLi.appendChild(photoImg);
    photoUl.appendChild(photoLi);
  });

});
