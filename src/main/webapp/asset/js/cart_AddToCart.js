console.log("✅ JS loaded");

document.addEventListener("DOMContentLoaded", function () {
    // Tự động lấy cart count khi tải trang
    updateCartCountFromServer();

    // Gán sự kiện cho các nút thêm vào giỏ hàng
    document.querySelectorAll(".add_to_cart").forEach(function (button) {
        button.addEventListener("click", function () {
            let partId = this.getAttribute("part-id");

            fetch(`/DriveXO_Management_Project/AddToCartServlet`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
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
                    if (!data) return;

                    console.log("Server Response:", data);

                    if (data.status === "success") {
                        console.log("Thêm vào giỏ hàng thành công!");

                        // Cập nhật cart count
                        const cartCountElem = document.getElementById("cart-count");
                        if (cartCountElem) {
                            cartCountElem.innerText = data.cartCount || 0;
                        }

                        showCartNotification("Product has been added to cart!", "green");

                        // Cập nhật lại stock hiển thị
                        const stockElem = this.closest('.card').querySelector('.stock-text');
                        if (stockElem && typeof data.partStock !== "undefined") {
                            stockElem.innerHTML = `<i class="fas fa-box"></i> Stock: ${data.partStock}`;
                        }

                    } else if (data.status === "out_of_stock") {
                        showCartNotification("This product is out of stock!", "orange");
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

// Hàm gọi servlet để cập nhật cart count khi load trang
function updateCartCountFromServer() {
    fetch('/DriveXO_Management_Project/GetCartCountServlet')
        .then(response => response.json())
        .then(data => {
            const cartCountElem = document.getElementById("cart-count");
            if (cartCountElem) {
                cartCountElem.innerText = data.cartCount || 0;
            }
        })
        .catch(error => {
            console.error("Không thể lấy cart count:", error);
        });
}

// Hàm hiển thị thông báo với màu sắc tùy chỉnh
function showCartNotification(message, color) {
    let notification = document.getElementById("cart-notification");
    if (!notification) return;

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
