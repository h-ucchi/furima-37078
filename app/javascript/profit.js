function profit (){
  const itemPrice  = document.getElementById("item-price"); //（）の中はid名を書く
  itemPrice.addEventListener("keyup", () => {
    const calcuVal = Math.floor(itemPrice.value * 0.9) ;
    const Profit  = document.getElementById("profit"); //（）の中はid名を書く
    Profit.innerHTML = `${calcuVal}`;
  });
};

window.addEventListener('load', profit);
