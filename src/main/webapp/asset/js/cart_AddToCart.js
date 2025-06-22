console.log("✅ JS loaded");
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".add_to_cart").forEach(function (button) {
        button.addEventListener("click", function () {
            let partId = this.getAttribute("part-id");

            fetch(`/DriveXO_Management_Project/AddToCartServlet`, {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: "id=" + encodeURIComponent(partId)
            })
                    .then(response => {

                        if (response.redirected) {
                            window.location.href = response.url; // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
                            return;
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (!data)
                            return; // Nếu đã bị redirect thì không làm gì nữa

                        console.log("Server Response:", data);

                        if (data.status === "success") {
                            console.log("Thêm vào giỏ hàng thành công!");
                            document.getElementById("cart-count").innerText = data.cartCount || 0;
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
    notification.style.backgroundColor = color; // Đổi màu theo trạng thái
    notification.style.color = "black"; // Đảm bảo chữ dễ đọc
    notification.style.padding = "10px";
    notification.style.borderRadius = "5px";

    setTimeout(() => {
        notification.style.display = "none";
    }, 2000);
}
