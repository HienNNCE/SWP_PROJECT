// Main JavaScript file - Minimal Version

document.addEventListener('DOMContentLoaded', function() {
    console.log("DOM đã được tải xong");
    
    // Kiểm tra các phần tử trên trang
    console.log("Kiểm tra các phần tử filter-tab:", document.querySelectorAll('.filter-tab').length);
    console.log("Kiểm tra các phần tử brand-item:", document.querySelectorAll('.brand-item').length);
    console.log("Kiểm tra các phần tử fuel-option:", document.querySelectorAll('.fuel-option').length);
    console.log("Kiểm tra các phần tử year-option:", document.querySelectorAll('.year-option').length);
    
    // Thêm sự kiện click vào document để kiểm tra
    document.addEventListener('click', function(e) {
        console.log("Click được kích hoạt trên phần tử:", e.target);
        console.log("Class của phần tử:", e.target.className);
    });
    
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
    
    // Khởi tạo chức năng cho trang danh sách xe
    // Kiểm tra xem có đang ở trang car-list không
    if (document.querySelector('.car-listing-page')) {
        console.log("Đang ở trang car-list, khởi tạo các chức năng");
        initCarListFunctions();
    }
});

// Hàm khởi tạo tất cả chức năng cho trang danh sách xe
function initCarListFunctions() {
    console.log("Đang khởi tạo chức năng car list...");
    
    // Toggle Grid/List View
    const gridViewBtn = document.getElementById('gridView');
    const listViewBtn = document.getElementById('listView');
    const carsGrid = document.getElementById('carsGrid');
    
    if (gridViewBtn && listViewBtn && carsGrid) {
        console.log("Khởi tạo chức năng chuyển đổi chế độ xem");
        gridViewBtn.addEventListener('click', function() {
            carsGrid.classList.remove('list-view');
            gridViewBtn.classList.add('active');
            listViewBtn.classList.remove('active');
            localStorage.setItem('carViewPreference', 'grid');
        });
        
        listViewBtn.addEventListener('click', function() {
            carsGrid.classList.add('list-view');
            listViewBtn.classList.add('active');
            gridViewBtn.classList.remove('active');
            localStorage.setItem('carViewPreference', 'list');
        });
        
        // Load user preference from local storage
        const savedViewPreference = localStorage.getItem('carViewPreference');
        if (savedViewPreference === 'list') {
            listViewBtn.click();
        }
    } else {
        console.log("Không tìm thấy các phần tử chuyển đổi chế độ xem");
    }
    
    // Filter tabs functionality with smooth scroll
    const filterTabs = document.querySelectorAll('.filter-tab');
    const filterTabsContainer = document.querySelector('.filter-tabs-container');
    const filterTabsWrapper = document.querySelector('.filter-tabs');
    
    console.log("Filter tabs:", filterTabs ? filterTabs.length : 0);
    console.log("Filter tabs container:", filterTabsContainer ? "found" : "not found");
    console.log("Filter tabs wrapper:", filterTabsWrapper ? "found" : "not found");
    
    // Scroll to active tab on page load
    if (filterTabsContainer && filterTabsWrapper) {
        const activeTab = document.querySelector('.filter-tab.active');
        if (activeTab) {
            console.log("Tìm thấy tab active, cuộn đến vị trí");
            setTimeout(() => {
                // Scroll active tab into center view
                const containerWidth = filterTabsContainer.offsetWidth;
                const activeTabLeft = activeTab.offsetLeft;
                const activeTabWidth = activeTab.offsetWidth;
                const scrollPosition = activeTabLeft - (containerWidth / 2) + (activeTabWidth / 2);
                
                filterTabsContainer.scrollTo({
                    left: scrollPosition,
                    behavior: 'smooth'
                });
            }, 100);
        }
        
        // Add mousewheel horizontal scrolling
        filterTabsContainer.addEventListener('wheel', (e) => {
            if (e.deltaY !== 0) {
                e.preventDefault();
                filterTabsContainer.scrollLeft += e.deltaY;
            }
        });
        
        // Add drag scrolling
        let isDown = false;
        let startX;
        let scrollLeft;
        
        filterTabsContainer.addEventListener('mousedown', (e) => {
            isDown = true;
            filterTabsContainer.style.cursor = 'grabbing';
            startX = e.pageX - filterTabsContainer.offsetLeft;
            scrollLeft = filterTabsContainer.scrollLeft;
        });
        
        filterTabsContainer.addEventListener('mouseleave', () => {
            isDown = false;
            filterTabsContainer.style.cursor = 'grab';
        });
        
        filterTabsContainer.addEventListener('mouseup', () => {
            isDown = false;
            filterTabsContainer.style.cursor = 'grab';
        });
        
        filterTabsContainer.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - filterTabsContainer.offsetLeft;
            const walk = (x - startX) * 2; // Speed multiplier
            filterTabsContainer.scrollLeft = scrollLeft - walk;
        });
        
        // Add grab cursor
        filterTabsContainer.style.cursor = 'grab';
    }
    
    if (filterTabs && filterTabs.length > 0) {
        console.log("Thêm sự kiện click cho các tab filter");
        filterTabs.forEach(tab => {
            tab.addEventListener('click', function(e) {
                console.log("Tab clicked:", this.getAttribute('data-category'));
                // Prevent immediate navigation to allow animation
                e.preventDefault();
                
                // Add transitioning class to parent
                if (filterTabsWrapper) {
                    filterTabsWrapper.classList.add('transitioning');
                }
                
                // Remove active class from all tabs
                filterTabs.forEach(t => {
                    t.classList.remove('active');
                });
                
                // Add active class to clicked tab
                this.classList.add('active');
                
                // Smooth scroll to center the active tab
                if (filterTabsContainer) {
                    const containerWidth = filterTabsContainer.offsetWidth;
                    const activeTabLeft = this.offsetLeft;
                    const activeTabWidth = this.offsetWidth;
                    const scrollPosition = activeTabLeft - (containerWidth / 2) + (activeTabWidth / 2);
                    
                    filterTabsContainer.scrollTo({
                        left: scrollPosition,
                        behavior: 'smooth'
                    });
                }
                
                // Get category from the clicked tab
                const category = this.getAttribute('data-category');
                
                // Reset brand selection
                const brandItems = document.querySelectorAll('.brand-item');
                brandItems.forEach(brand => {
                    if (brand.getAttribute('data-brand') === 'all') {
                        brand.classList.add('selected');
                    } else {
                        brand.classList.remove('selected');
                    }
                });
                
                // Load cars with selected category
                loadCarsWithFilters({
                    category: category === 'all' ? null : category
                });
            });
        });
    } else {
        console.log("Không tìm thấy các tab filter");
    }
    
    // Filter options functionality
    const filterOptions = document.querySelectorAll('.filter-option');
    if (filterOptions && filterOptions.length > 0) {
        console.log("Thêm sự kiện click cho các option filter");
        filterOptions.forEach(option => {
            option.addEventListener('click', function() {
                const filterType = this.getAttribute('data-filter');
                const filterValue = this.getAttribute('data-value');
                
                // Toggle selection within the same filter group
                const siblings = document.querySelectorAll('.filter-option[data-filter="' + filterType + '"]');
                siblings.forEach(sib => sib.classList.remove('selected'));
                this.classList.toggle('selected');
            });
        });
    }
    
    // Price range slider
    const priceRangeSlider = document.getElementById('priceRange');
    const priceValueDisplay = document.getElementById('priceValue');
    const minPriceInput = document.getElementById('minPrice');
    const maxPriceInput = document.getElementById('maxPrice');
    
    if (priceRangeSlider && priceValueDisplay) {
        console.log("Khởi tạo price range slider");
        // Set initial value from hidden inputs or default
        const minPrice = parseInt(minPriceInput?.value || 25000);
        const maxPrice = parseInt(maxPriceInput?.value || 125000);
        priceRangeSlider.value = maxPrice;
        updatePriceDisplay();
        
        priceRangeSlider.addEventListener('input', updatePriceDisplay);
        
        function updatePriceDisplay() {
            const value = priceRangeSlider.value;
            priceValueDisplay.textContent = '$' + formatPrice(value);
            if (maxPriceInput) maxPriceInput.value = value;
        }
    }
    
    // ODO range slider
    const odoRangeSlider = document.getElementById('odoRange');
    const odoValueDisplay = document.getElementById('odoValue');
    const minOdoInput = document.getElementById('minOdo');
    const maxOdoInput = document.getElementById('maxOdo');
    
    if (odoRangeSlider && odoValueDisplay) {
        console.log("Khởi tạo odo range slider");
        // Set initial value from hidden inputs or default
        const minOdo = parseInt(minOdoInput?.value || 0);
        const maxOdo = parseInt(maxOdoInput?.value || 100000);
        odoRangeSlider.value = maxOdo;
        updateOdoDisplay();
        
        odoRangeSlider.addEventListener('input', updateOdoDisplay);
        
        function updateOdoDisplay() {
            const value = odoRangeSlider.value;
            odoValueDisplay.textContent = formatPrice(value);
            if (maxOdoInput) maxOdoInput.value = value;
        }
    }
    
    // Apply and Reset filters
    const resetFiltersBtn = document.getElementById('resetFilters_toolbar');
    const applyFiltersBtn = document.getElementById('applyFilters_toolbar');
    
    // Search input
    const carSearchInput = document.getElementById('carSearchInput');
    let searchTerm = null;
    
    if (carSearchInput) {
        console.log("Khởi tạo search input");
        // Lưu giá trị tìm kiếm khi người dùng nhập
        carSearchInput.addEventListener('input', function() {
            searchTerm = this.value.trim();
        });
        
        // Xử lý khi người dùng nhấn Enter
        carSearchInput.addEventListener('keyup', function(e) {
            if (e.key === 'Enter') {
                if (applyFiltersBtn) applyFiltersBtn.click();
            }
        });
    }
    
    // Year Picker
    const yearInput = document.getElementById('yearInput');
    const yearDropdown = document.getElementById('yearDropdown');
    const yearOptions = document.querySelectorAll('.year-option');
    const yearDisplayValue = document.getElementById('yearDisplayValue');
    let selectedYearValue = null;
    
    if (yearInput && yearDropdown) {
        console.log("Khởi tạo year picker");
        // Toggle dropdown
        yearInput.addEventListener('click', function() {
            console.log("Year input clicked");
            yearDropdown.classList.toggle('show');
        });
        
        // Hide dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (yearInput && yearDropdown && !yearInput.contains(e.target) && !yearDropdown.contains(e.target)) {
                yearDropdown.classList.remove('show');
            }
        });
        
        // Select year
        if (yearOptions && yearOptions.length > 0) {
            yearOptions.forEach(option => {
                option.addEventListener('click', function() {
                    const year = this.getAttribute('data-year');
                    console.log("Year selected:", year);
                    yearOptions.forEach(opt => opt.classList.remove('selected'));
                    this.classList.add('selected');
                    
                    if (year === 'all') {
                        yearInput.textContent = 'Select Year';
                        yearDisplayValue.textContent = 'All';
                        selectedYearValue = null;
                    } else {
                        yearInput.textContent = year;
                        yearDisplayValue.textContent = year;
                        selectedYearValue = year;
                    }
                    yearDropdown.classList.remove('show');
                });
            });
        }
    }
    
    // Fuel Type Selection
    const fuelOptions = document.querySelectorAll('.fuel-option');
    let selectedFuelType = null;
    
    if (fuelOptions && fuelOptions.length > 0) {
        console.log("Khởi tạo fuel type selection");
        fuelOptions.forEach(option => {
            option.addEventListener('click', function() {
                console.log("Fuel option clicked:", this.getAttribute('data-fuel'));
                const isSelected = this.classList.contains('selected');
                fuelOptions.forEach(opt => opt.classList.remove('selected'));
                
                if (!isSelected) {
                    this.classList.add('selected');
                    selectedFuelType = this.getAttribute('data-fuel');
                } else {
                    selectedFuelType = null;
                }
            });
        });
    }
    
    if (resetFiltersBtn) {
        console.log("Khởi tạo reset filters button");
        resetFiltersBtn.addEventListener('click', function() {
            console.log("Reset filters clicked");
            window.location.href = contextPath + '/car/list';
        });
    }
    
    if (applyFiltersBtn) {
        console.log("Khởi tạo apply filters button");
        applyFiltersBtn.addEventListener('click', function() {
            console.log("Apply filters clicked");
            const filters = {};
            
            // Get selected category
            const activeTab = document.querySelector('.filter-tab.active');
            if (activeTab) {
                const category = activeTab.getAttribute('data-category');
                if (category !== 'all') {
                    filters.category = category;
                }
            }
            
            // Get selected brand
            const selectedBrand = document.querySelector('.brand-item.selected');
            if (selectedBrand) {
                const brand = selectedBrand.getAttribute('data-brand');
                if (brand !== 'all') {
                    filters.brand = brand;
                }
            }
            
            // Get selected year from new year picker
            if (selectedYearValue) {
                filters.year = selectedYearValue;
            }
            
            // Get selected fuel type from new fuel options
            if (selectedFuelType) {
                filters.fuel = selectedFuelType;
            }
            
            // Get price range
            if (minPriceInput && maxPriceInput) {
                filters.price = minPriceInput.value + '-' + maxPriceInput.value;
            }
            
            // Get odo range
            if (minOdoInput && maxOdoInput) {
                filters.odo = minOdoInput.value + '-' + maxOdoInput.value;
            }
            
            // Get search term
            if (searchTerm && searchTerm.length > 0) {
                filters.search = searchTerm;
            }
            
            console.log("Filters to apply:", filters);
            
            // Load cars with all filters
            loadCarsWithFilters(filters);
        });
    }
    
    // Brand carousel controls
    const brandCarousel = document.getElementById('brandCarousel');
    const brandPrev = document.getElementById('brandPrev');
    const brandNext = document.getElementById('brandNext');
    const brandItems = document.querySelectorAll('.brand-item');
    
    if (brandCarousel && brandPrev && brandNext) {
        console.log("Khởi tạo brand carousel");
        // Scroll amount for arrow buttons
        const scrollAmount = 300;
        
        // Scroll left button
        brandPrev.addEventListener('click', () => {
            console.log("Brand prev clicked");
            brandCarousel.scrollBy({
                left: -scrollAmount,
                behavior: 'smooth'
            });
        });
        
        // Scroll right button
        brandNext.addEventListener('click', () => {
            console.log("Brand next clicked");
            brandCarousel.scrollBy({
                left: scrollAmount,
                behavior: 'smooth'
            });
        });
        
        // Kiểm tra xem có nên hiển thị nút mũi tên không
        const checkArrowVisibility = () => {
            if (brandCarousel.scrollWidth <= brandCarousel.clientWidth) {
                // Nếu không có cuộn ngang, ẩn cả hai nút
                brandPrev.style.display = 'none';
                brandNext.style.display = 'none';
            } else {
                // Hiển thị nút nếu cần cuộn
                brandPrev.style.display = 'flex';
                brandNext.style.display = 'flex';
                
                // Kiểm tra vị trí cuộn để làm mờ nút khi cần
                if (brandCarousel.scrollLeft <= 10) {
                    brandPrev.style.opacity = '0.5';
                    brandPrev.style.pointerEvents = 'none';
                } else {
                    brandPrev.style.opacity = '1';
                    brandPrev.style.pointerEvents = 'auto';
                }
                
                if (brandCarousel.scrollLeft + brandCarousel.clientWidth >= brandCarousel.scrollWidth - 10) {
                    brandNext.style.opacity = '0.5';
                    brandNext.style.pointerEvents = 'none';
                } else {
                    brandNext.style.opacity = '1';
                    brandNext.style.pointerEvents = 'auto';
                }
            }
        };
        
        // Update arrow visibility on scroll
        brandCarousel.addEventListener('scroll', checkArrowVisibility);
        
        // Initial check
        checkArrowVisibility();
        
        // Check on window resize
        window.addEventListener('resize', checkArrowVisibility);
        
        // Brand selection
        if (brandItems && brandItems.length > 0) {
            console.log("Khởi tạo brand selection, số lượng:", brandItems.length);
            brandItems.forEach(item => {
                item.addEventListener('click', function() {
                    console.log("Brand item clicked:", this.getAttribute('data-brand'));
                    // Remove selected class from all items
                    brandItems.forEach(brand => brand.classList.remove('selected'));
                    
                    // Add selected class to clicked item
                    this.classList.add('selected');
                    
                    // Get selected brand
                    const selectedBrand = this.getAttribute('data-brand');
                    
                    // Load cars with selected brand
                    if (selectedBrand && selectedBrand !== 'all') {
                        loadCarsWithFilters({brand: selectedBrand});
                    } else {
                        loadCarsWithFilters({});
                    }
                });
            });
        }
        
        // Prevent horizontal scroll wheel event on brand carousel
        brandCarousel.addEventListener('wheel', (e) => {
            if (e.deltaY !== 0) {
                e.preventDefault();
                brandCarousel.scrollLeft += e.deltaY;
            }
        });
    }
}

// Format price with commas
function formatPrice(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// Hàm để tải xe với các bộ lọc
function loadCarsWithFilters(filters) {
    console.log("Đang tải xe với filters:", filters);
    
    // Get context path từ biến toàn cục hoặc suy luận
    const contextPath = window.contextPath || "";
    console.log("Context path:", contextPath);
    
    // Show loading indicator
    const carsGrid = document.getElementById('carsGrid');
    if (carsGrid) {
        carsGrid.innerHTML = '<div class="loading-indicator"><i class="fas fa-spinner fa-spin"></i><span>Loading vehicles...</span></div>';
    }
    
    // Build URL with filters
    let url = contextPath + '/car/list';
    const params = [];
    
    // Add all filters to params
    if (filters.brand) params.push('brand=' + filters.brand);
    if (filters.category) params.push('category=' + filters.category);
    if (filters.year) params.push('year=' + filters.year);
    if (filters.fuel) params.push('fuel=' + filters.fuel);
    if (filters.price) params.push('price=' + filters.price);
    if (filters.odo) params.push('odo=' + filters.odo);
    if (filters.search) params.push('search=' + encodeURIComponent(filters.search));
    
    // Append params to URL
    if (params.length > 0) {
        url += '?' + params.join('&');
    }
    
    // Add AJAX parameter
    url += (url.includes('?') ? '&' : '?') + 'ajax=true';
    
    console.log("URL to fetch:", url);
    
    // Fetch cars data using AJAX
    fetch(url)
        .then(response => {
            console.log("Response status:", response.status);
            return response.text();
        })
        .then(html => {
            console.log("Received HTML response");
            // Tạo element tạm để phân tích HTML
            const tempDiv = document.createElement('div');
            tempDiv.innerHTML = html;
            
            // Lấy nội dung grid xe mới
            const newCarsGrid = tempDiv.querySelector('#carsGrid');
            const totalCars = tempDiv.querySelector('.cars-count');
            const pagination = tempDiv.querySelector('.pagination');
            
            // Cập nhật DOM với nội dung mới
            if (newCarsGrid && carsGrid) {
                carsGrid.innerHTML = newCarsGrid.innerHTML;
                console.log("Đã cập nhật grid xe");
            } else {
                console.log("Không tìm thấy grid xe mới hoặc grid xe hiện tại");
            }
            
            // Cập nhật số lượng xe
            if (totalCars) {
                const currentTotalCars = document.querySelector('.cars-count');
                if (currentTotalCars) {
                    currentTotalCars.innerHTML = totalCars.innerHTML;
                    console.log("Đã cập nhật số lượng xe");
                }
            }
            
            // Cập nhật phân trang
            if (pagination) {
                const currentPagination = document.querySelector('.pagination');
                if (currentPagination) {
                    currentPagination.innerHTML = pagination.innerHTML;
                    console.log("Đã cập nhật phân trang");
                }
            }
            
            // Cập nhật URL không reload trang
            let newUrl = contextPath + '/car/list';
            if (params.length > 0) {
                newUrl += '?' + params.join('&');
            }
            window.history.pushState({ path: newUrl }, '', newUrl);
            console.log("Đã cập nhật URL:", newUrl);
            
            // Cuộn lên đầu phần xe
            const toolbar = document.querySelector('.cars-toolbar');
            if (toolbar) {
                toolbar.scrollIntoView({ behavior: 'smooth' });
            }
        })
        .catch(error => {
            console.error('Error loading page:', error);
            if (carsGrid) {
                carsGrid.innerHTML = '<div class="error-message"><i class="fas fa-exclamation-circle"></i>Failed to load vehicles. Please try again.</div>';
            }
        });
} 