function price (){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const addProfitDom = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString();
    addProfitDom.innerHTML = Math.floor(inputValue - Math.floor(inputValue * 0.1)).toLocaleString();
  });
};

window.addEventListener('load', price);