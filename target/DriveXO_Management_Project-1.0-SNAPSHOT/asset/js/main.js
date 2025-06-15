// Main JavaScript file - Minimal Version

document.addEventListener('DOMContentLoaded', function() {
    // Cookie consent functionality
    const cookieConsent = document.querySelector('.cookie-consent');
    const acceptBtn = document.querySelector('.accept-btn');
    const closeBtn = document.querySelector('.close-btn');
    
    if (cookieConsent && acceptBtn && closeBtn) {
        acceptBtn.addEventListener('click', function() {
            cookieConsent.style.display = 'none';
            localStorage.setItem('cookieAccepted', 'true');
        });
        
        closeBtn.addEventListener('click', function() {
            cookieConsent.style.display = 'none';
        });
        
        // Check if user has already accepted cookies
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
    
    // Header scroll effect
    const header = document.querySelector('.header');
    if (header) {
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
    }
}); 