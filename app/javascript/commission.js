function commission (){
  const itemPrice  = document.getElementById("item-price"); //（）の中はid名を書く
  itemPrice.addEventListener("keyup", () => {
    const calcuVal = Math.floor(itemPrice.value * 0.1) ;
    const addtaxPrice  = document.getElementById("add-tax-price"); //（）の中はid名を書く
    addtaxPrice.innerHTML = `${calcuVal}`;
  });
};

window.addEventListener('load', commission);
