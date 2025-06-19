// Main JavaScript file

document.addEventListener('DOMContentLoaded', function() {
    // Xử lý hình ảnh hero-car
    const heroCar = document.getElementById('hero-car-image');
    if (heroCar) {
        // Đảm bảo ảnh tải đúng
        heroCar.onload = function() {
            console.log('Hero car image loaded successfully');
        };
        
        heroCar.onerror = function() {
            console.error('Failed to load hero car image');
            // Thay thế bằng ảnh mặc định nếu cần
            // heroCar.src = 'asset/img/placeholder.png';
        };
    }
    
    // Xử lý cookie consent
    const cookieConsent = document.querySelector('.cookie-consent');
    const acceptBtn = document.querySelector('.accept-btn');
    const closeBtn = document.querySelector('.close-btn');
    
    if (cookieConsent && acceptBtn && closeBtn) {
        acceptBtn.addEventListener('click', function() {
            cookieConsent.style.display = 'none';
            // Lưu trạng thái đã chấp nhận cookie
            localStorage.setItem('cookieAccepted', 'true');
        });
        
        closeBtn.addEventListener('click', function() {
            cookieConsent.style.display = 'none';
        });
        
        // Kiểm tra xem người dùng đã chấp nhận cookie chưa
        if (localStorage.getItem('cookieAccepted') === 'true') {
            cookieConsent.style.display = 'none';
        }
    }
    
    // Dropdown menu
    const dropdowns = document.querySelectorAll('.has-dropdown');
    if (dropdowns.length > 0) {
        dropdowns.forEach(function(dropdown) {
            dropdown.addEventListener('click', function(e) {
                e.stopPropagation();
                this.classList.toggle('active');
            });
        });
        
        document.addEventListener('click', function() {
            dropdowns.forEach(function(dropdown) {
                dropdown.classList.remove('active');
            });
        });
    }
    
    // Đổi ảnh trong trang car-detail.jsp
    function changeImage(src) {
        const mainImage = document.getElementById('main-car-image');
        if (mainImage) {
            mainImage.src = src;
            
            // Update active thumbnail
            const thumbnails = document.querySelectorAll('.thumbnail');
            thumbnails.forEach(thumb => {
                thumb.classList.remove('active');
                if (thumb.querySelector('img').src === src) {
                    thumb.classList.add('active');
                }
            });
        }
    }
    
    // Expose function to global scope for inline event handlers
    window.changeImage = changeImage;
}); 