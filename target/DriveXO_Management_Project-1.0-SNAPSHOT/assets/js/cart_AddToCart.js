console.log("✅ JS loaded");
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".card__favorite").forEach(function (button) {
        button.addEventListener("click", function () {
            let partId = this.getAttribute("part-id");

            fetch(`/DriveXO_Management_Project/AddToCartServlet`, {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "id=" + encodeURIComponent(partId)
            })
                    .then(response => {

                        if (response.redirected) {
                            window.location.href = response.url; 
                            return;
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (!data)
                            return; 

                        console.log("Server Response:", data);

                        if (data.status === "success") {
                            console.log("Thêm vào giỏ hàng thành công!");
                            document.getElementById("item-count").innerText = data.cartCount || 0;
                            document.getElementById("cart-total-price").innerText = "$" + data.totalPrice.toFixed(2);
                            showCartNotification("Product has been added to cart!", "green");
                        } else {
                            showCartNotification("Unknown error!", "red");
                        }
                    })
                    .catch(error => {
                        console.error("Fetch Error:", error);
                        showCartNotification("Connection error!", "red");
                    });
        });
    });
});



// Hàm hiển thị thông báo với màu sắc tùy chỉnh
function showCartNotification(message, color) {
    let notification = document.getElementById("cart-notification");
    notification.innerText = message;
    notification.style.display = "block";
    notification.style.backgroundColor = color;
    notification.style.color = "black";
    notification.style.padding = "10px";
    notification.style.borderRadius = "5px";

    setTimeout(() => {
        notification.style.display = "none";
    }, 2000);
}
