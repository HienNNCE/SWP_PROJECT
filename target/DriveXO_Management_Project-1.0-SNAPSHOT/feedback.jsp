<%-- 
    Document   : feedback
    Created on : May 28, 2025, 12:30:00 PM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Feedback - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .feedback-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .feedback-wrapper {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 30px;
            }
            
            @media (max-width: 992px) {
                .feedback-wrapper {
                    grid-template-columns: 1fr;
                }
            }
            
            .feedback-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                padding: 25px;
                margin-bottom: 30px;
            }
            
            .feedback-card-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                color: #333;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .feedback-card-title i {
                color: var(--primary-color);
            }
            
            .form-info-text {
                margin-bottom: 20px;
                color: #555;
                line-height: 1.6;
            }
            
            .feedback-form {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }
            
            .form-group {
                margin-bottom: 5px;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #555;
            }
            
            .form-control {
                display: block;
                width: 100%;
                padding: 12px 15px;
                font-size: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: border-color 0.3s;
            }
            
            .form-control:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.15);
            }
            
            textarea.form-control {
                resize: vertical;
                min-height: 150px;
            }
            
            .rating-group {
                margin-bottom: 20px;
            }
            
            .rating-label {
                display: block;
                margin-bottom: 10px;
                font-weight: 500;
                color: #555;
            }
            
            .star-rating {
                display: flex;
                gap: 10px;
                font-size: 24px;
                color: #ddd;
            }
            
            .star-rating i {
                cursor: pointer;
                transition: color 0.2s;
            }
            
            .star-rating i.active {
                color: #ffc107;
            }
            
            .rating-text {
                margin-top: 5px;
                font-size: 14px;
                color: #777;
            }
            
            .feedback-types {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 20px;
            }
            
            .feedback-type {
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 20px;
                padding: 8px 15px;
                font-size: 14px;
                color: #555;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .feedback-type:hover {
                background-color: #f1f3f5;
                border-color: #ccc;
            }
            
            .feedback-type.active {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            .feedback-actions {
                margin-top: 10px;
                display: flex;
                justify-content: flex-end;
                gap: 15px;
            }
            
            .btn {
                padding: 12px 24px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s;
                border: none;
            }
            
            .btn-secondary {
                background-color: #f5f5f5;
                color: #333;
                border: 1px solid #ddd;
            }
            
            .btn-secondary:hover {
                background-color: #e9e9e9;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: #fff;
            }
            
            .btn-primary:hover {
                background-color: var(--secondary-color);
            }
            
            /* Your Feedback section */
            .feedback-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            
            .feedback-header-title {
                font-size: 20px;
                font-weight: 600;
                color: #333;
            }
            
            .feedback-filter {
                display: flex;
                gap: 15px;
                align-items: center;
            }
            
            .filter-label {
                font-size: 14px;
                color: #555;
            }
            
            .filter-select {
                padding: 8px 12px;
                border-radius: 5px;
                border: 1px solid #ddd;
                color: #333;
                font-size: 14px;
            }
            
            .feedback-list {
                max-height: 600px;
                overflow-y: auto;
                padding-right: 10px;
            }
            
            .feedback-item {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                border-left: 4px solid var(--primary-color);
                position: relative;
            }
            
            .feedback-item:last-child {
                margin-bottom: 0;
            }
            
            .feedback-item-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            
            .feedback-item-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 0;
            }
            
            .feedback-item-date {
                font-size: 14px;
                color: #777;
            }
            
            .feedback-item-rating {
                color: #ffc107;
                margin-bottom: 10px;
            }
            
            .feedback-item-text {
                color: #555;
                line-height: 1.6;
                margin-bottom: 15px;
            }
            
            .feedback-item-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                margin-bottom: 15px;
            }
            
            .feedback-tag {
                background-color: #e9ecef;
                color: #495057;
                border-radius: 20px;
                padding: 4px 10px;
                font-size: 12px;
            }
            
            .feedback-item-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 10px;
                border-top: 1px solid #eee;
            }
            
            .feedback-reply {
                color: #666;
                font-style: italic;
            }
            
            .feedback-actions-btn {
                display: flex;
                gap: 10px;
            }
            
            .feedback-edit-btn,
            .feedback-delete-btn {
                background: none;
                border: none;
                color: #777;
                cursor: pointer;
                transition: color 0.3s;
            }
            
            .feedback-edit-btn:hover {
                color: var(--primary-color);
            }
            
            .feedback-delete-btn:hover {
                color: #dc3545;
            }
            
            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                overflow: auto;
            }
            
            .modal-content {
                background-color: #fff;
                margin: 50px auto;
                width: 100%;
                max-width: 600px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                animation: modalFadeIn 0.3s;
            }
            
            @keyframes modalFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .modal-header {
                padding: 20px;
                border-bottom: 1px solid #eee;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .modal-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--primary-color);
                margin: 0;
            }
            
            .close-modal {
                background: none;
                border: none;
                font-size: 22px;
                color: #999;
                cursor: pointer;
            }
            
            .modal-body {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                border-top: 1px solid #eee;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }
            
            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 5px;
                margin-top: 30px;
            }
            
            .pagination a {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 5px;
                background-color: #fff;
                color: #555;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s;
                border: 1px solid #ddd;
            }
            
            .pagination a:hover {
                background-color: #f8f9fa;
            }
            
            .pagination a.active {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            /* Prevent scrolling when modal is open */
            body.modal-open {
                overflow: hidden;
            }
            
            /* Additional responsive styles */
            @media (max-width: 768px) {
                .feedback-item-header {
                    flex-direction: column;
                    gap: 5px;
                }
                
                .feedback-actions-btn {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                }
                
                .feedback-item-title {
                    margin-right: 60px; /* Make space for action buttons */
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <h1>Feedback</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Feedback</span>
                </div>
            </div>
        </section>

        <!-- Feedback Section -->
        <section class="feedback-section">
            <div class="container">
                <div class="feedback-wrapper">
                    <!-- Submit Feedback Form -->
                    <div>
                        <div class="feedback-card">
                            <h2 class="feedback-card-title"><i class="fas fa-comment-alt"></i> Submit Your Feedback</h2>
                            <p class="form-info-text">We value your feedback! Please share your experiences, suggestions, or concerns. Your input helps us improve our services and better meet your needs.</p>
                            <form class="feedback-form" id="feedbackForm">
                                <div class="form-group">
                                    <label for="feedback_title">Subject</label>
                                    <input type="text" id="feedback_title" class="form-control" placeholder="Brief title for your feedback">
                                </div>
                                
                                <div class="rating-group">
                                    <span class="rating-label">How would you rate your overall experience?</span>
                                    <div class="star-rating" id="star-rating">
                                        <i class="fas fa-star" data-rating="1"></i>
                                        <i class="fas fa-star" data-rating="2"></i>
                                        <i class="fas fa-star" data-rating="3"></i>
                                        <i class="fas fa-star" data-rating="4"></i>
                                        <i class="fas fa-star" data-rating="5"></i>
                                    </div>
                                    <div class="rating-text" id="rating-text">Click to rate</div>
                                    <input type="hidden" id="rating_value" name="rating" value="">
                                </div>
                                
                                <div class="form-group">
                                    <label>Feedback Type</label>
                                    <div class="feedback-types">
                                        <div class="feedback-type" data-type="general">General</div>
                                        <div class="feedback-type" data-type="product">Products</div>
                                        <div class="feedback-type" data-type="service">Services</div>
                                        <div class="feedback-type" data-type="website">Website</div>
                                        <div class="feedback-type" data-type="staff">Staff</div>
                                        <div class="feedback-type" data-type="suggestion">Suggestion</div>
                                    </div>
                                    <input type="hidden" id="feedback_type" name="type" value="">
                                </div>
                                
                                <div class="form-group">
                                    <label for="feedback_message">Your Feedback</label>
                                    <textarea id="feedback_message" class="form-control" rows="6" placeholder="Tell us about your experience, suggestions, or concerns..."></textarea>
                                </div>
                                
                                <div class="feedback-actions">
                                    <button type="button" class="btn btn-secondary" id="resetBtn">Clear</button>
                                    <button type="submit" class="btn btn-primary">Submit Feedback</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Your Feedback -->
                    <div>
                        <div class="feedback-card">
                            <div class="feedback-header">
                                <h2 class="feedback-header-title">Your Feedback History</h2>
                                <div class="feedback-filter">
                                    <span class="filter-label">Sort by:</span>
                                    <select class="filter-select">
                                        <option value="newest">Newest First</option>
                                        <option value="oldest">Oldest First</option>
                                        <option value="rating-high">Highest Rating</option>
                                        <option value="rating-low">Lowest Rating</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="feedback-list">
                                <!-- Feedback Item 1 -->
                                <div class="feedback-item">
                                    <div class="feedback-item-header">
                                        <h3 class="feedback-item-title">Excellent Customer Service</h3>
                                        <span class="feedback-item-date">May 15, 2025</span>
                                    </div>
                                    <div class="feedback-item-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <p class="feedback-item-text">I recently purchased a Chevrolet CamFó Explorer and was extremely impressed with the service I received. The staff was knowledgeable, friendly, and not pushy at all. They helped me find exactly what I was looking for and made the buying process smooth and easy.</p>
                                    <div class="feedback-item-tags">
                                        <span class="feedback-tag">Service</span>
                                        <span class="feedback-tag">Staff</span>
                                    </div>
                                    <div class="feedback-item-footer">
                                        <div class="feedback-reply">
                                            <strong>Response:</strong> Thank you for your kind words! We're thrilled to hear about your positive experience and look forward to serving you again.
                                        </div>
                                        <div class="feedback-actions-btn">
                                            <button class="feedback-edit-btn" data-id="1"><i class="fas fa-edit"></i></button>
                                            <button class="feedback-delete-btn" data-id="1"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Feedback Item 2 -->
                                <div class="feedback-item">
                                    <div class="feedback-item-header">
                                        <h3 class="feedback-item-title">Website Improvement Suggestion</h3>
                                        <span class="feedback-item-date">May 3, 2025</span>
                                    </div>
                                    <div class="feedback-item-rating">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                    <p class="feedback-item-text">Overall the website is good, but I think the car filter could be improved. It would be helpful to have more detailed filtering options such as transmission type, fuel efficiency, and specific features. This would make it easier to find exactly what I'm looking for.</p>
                                    <div class="feedback-item-tags">
                                        <span class="feedback-tag">Website</span>
                                        <span class="feedback-tag">Suggestion</span>
                                    </div>
                                    <div class="feedback-item-footer">
                                        <div class="feedback-reply">
                                            <strong>Response:</strong> Thank you for your feedback! We're currently working on improving our filtering system and will implement your suggestions in our next update.
                                        </div>
                                        <div class="feedback-actions-btn">
                                            <button class="feedback-edit-btn" data-id="2"><i class="fas fa-edit"></i></button>
                                            <button class="feedback-delete-btn" data-id="2"><i class="fas fa-trash"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="pagination">
                                <a href="#" class="active">1</a>
                                <a href="#">2</a>
                                <a href="#"><i class="fas fa-angle-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Edit Feedback Modal -->
        <div class="modal" id="editFeedbackModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Edit Feedback</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form id="editFeedbackForm">
                        <div class="form-group">
                            <label for="edit_feedback_title">Subject</label>
                            <input type="text" id="edit_feedback_title" class="form-control" value="Excellent Customer Service">
                        </div>
                        
                        <div class="rating-group">
                            <span class="rating-label">Rating</span>
                            <div class="star-rating" id="edit-star-rating">
                                <i class="fas fa-star active" data-rating="1"></i>
                                <i class="fas fa-star active" data-rating="2"></i>
                                <i class="fas fa-star active" data-rating="3"></i>
                                <i class="fas fa-star active" data-rating="4"></i>
                                <i class="fas fa-star active" data-rating="5"></i>
                            </div>
                            <div class="rating-text">5 stars - Excellent</div>
                            <input type="hidden" id="edit_rating_value" name="rating" value="5">
                        </div>
                        
                        <div class="form-group">
                            <label>Feedback Type</label>
                            <div class="feedback-types">
                                <div class="feedback-type" data-type="general">General</div>
                                <div class="feedback-type active" data-type="service">Service</div>
                                <div class="feedback-type active" data-type="staff">Staff</div>
                                <div class="feedback-type" data-type="product">Products</div>
                                <div class="feedback-type" data-type="website">Website</div>
                                <div class="feedback-type" data-type="suggestion">Suggestion</div>
                            </div>
                            <input type="hidden" id="edit_feedback_type" name="type" value="service,staff">
                        </div>
                        
                        <div class="form-group">
                            <label for="edit_feedback_message">Your Feedback</label>
                            <textarea id="edit_feedback_message" class="form-control" rows="6">I recently purchased a Chevrolet CamFó Explorer and was extremely impressed with the service I received. The staff was knowledgeable, friendly, and not pushy at all. They helped me find exactly what I was looking for and made the buying process smooth and easy.</textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary close-btn">Cancel</button>
                    <button class="btn btn-primary save-feedback-btn">Update Feedback</button>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Star Rating functionality
                const starRating = document.getElementById('star-rating');
                const ratingText = document.getElementById('rating-text');
                const ratingValue = document.getElementById('rating_value');
                const editStarRating = document.getElementById('edit-star-rating');
                const stars = starRating.querySelectorAll('.fa-star');
                const editStars = editStarRating ? editStarRating.querySelectorAll('.fa-star') : [];
                
                const ratingDescriptions = [
                    'Poor',
                    'Fair',
                    'Good',
                    'Very Good',
                    'Excellent'
                ];
                
                // Initialize rating functionality
                function initRating(container, stars, ratingField, textElement) {
                    stars.forEach(star => {
                        star.addEventListener('click', function() {
                            const rating = parseInt(this.getAttribute('data-rating'));
                            updateStars(stars, rating);
                            
                            if (ratingField) {
                                ratingField.value = rating;
                            }
                            
                            if (textElement) {
                                textElement.textContent = rating + ' stars - ' + ratingDescriptions[rating - 1];
                            }
                        });
                        
                        star.addEventListener('mouseover', function() {
                            const rating = parseInt(this.getAttribute('data-rating'));
                            hoverStars(stars, rating);
                        });
                        
                        star.addEventListener('mouseout', function() {
                            const currentRating = parseInt(ratingField ? ratingField.value : 0);
                            resetStars(stars, currentRating);
                        });
                    });
                }
                
                function updateStars(stars, rating) {
                    stars.forEach(star => {
                        const starRating = parseInt(star.getAttribute('data-rating'));
                        if (starRating <= rating) {
                            star.classList.add('active');
                        } else {
                            star.classList.remove('active');
                        }
                    });
                }
                
                function hoverStars(stars, rating) {
                    stars.forEach(star => {
                        const starRating = parseInt(star.getAttribute('data-rating'));
                        if (starRating <= rating) {
                            star.style.color = '#ffc107';
                        } else {
                            star.style.color = '#ddd';
                        }
                    });
                }
                
                function resetStars(stars, currentRating) {
                    stars.forEach(star => {
                        const starRating = parseInt(star.getAttribute('data-rating'));
                        star.style.color = '';
                        if (starRating <= currentRating) {
                            star.classList.add('active');
                        } else {
                            star.classList.remove('active');
                        }
                    });
                }
                
                if (starRating) {
                    initRating(starRating, stars, ratingValue, ratingText);
                }
                
                if (editStarRating) {
                    initRating(editStarRating, editStars);
                }
                
                // Feedback Type selection
                const feedbackTypes = document.querySelectorAll('.feedback-type');
                const feedbackTypeInput = document.getElementById('feedback_type');
                const editFeedbackTypeInput = document.getElementById('edit_feedback_type');
                
                feedbackTypes.forEach(type => {
                    type.addEventListener('click', function() {
                        const typeValue = this.getAttribute('data-type');
                        const isInEditModal = this.closest('#editFeedbackForm') !== null;
                        const targetInput = isInEditModal ? editFeedbackTypeInput : feedbackTypeInput;
                        
                        if (isInEditModal) {
                            // In edit mode, allow multiple selections
                            this.classList.toggle('active');
                            
                            // Update the hidden input with all selected types
                            const selectedTypes = Array.from(this.parentElement.querySelectorAll('.active'))
                                .map(el => el.getAttribute('data-type'))
                                .join(',');
                                
                            targetInput.value = selectedTypes;
                        } else {
                            // In new feedback mode, only one selection
                            feedbackTypes.forEach(t => t.classList.remove('active'));
                            this.classList.add('active');
                            targetInput.value = typeValue;
                        }
                    });
                });
                
                // Reset button functionality
                const resetBtn = document.getElementById('resetBtn');
                if (resetBtn) {
                    resetBtn.addEventListener('click', function() {
                        document.getElementById('feedbackForm').reset();
                        ratingValue.value = '';
                        feedbackTypeInput.value = '';
                        ratingText.textContent = 'Click to rate';
                        updateStars(stars, 0);
                        feedbackTypes.forEach(t => t.classList.remove('active'));
                    });
                }
                
                // Form submission
                const feedbackForm = document.getElementById('feedbackForm');
                if (feedbackForm) {
                    feedbackForm.addEventListener('submit', function(e) {
                        e.preventDefault();
                        
                        // Validate form fields
                        const title = document.getElementById('feedback_title').value.trim();
                        const message = document.getElementById('feedback_message').value.trim();
                        const rating = ratingValue.value;
                        const type = feedbackTypeInput.value;
                        
                        if (!title) {
                            alert('Please enter a subject for your feedback');
                            return;
                        }
                        
                        if (!rating) {
                            alert('Please rate your experience');
                            return;
                        }
                        
                        if (!type) {
                            alert('Please select a feedback type');
                            return;
                        }
                        
                        if (!message) {
                            alert('Please enter your feedback message');
                            return;
                        }
                        
                        // Here you would typically submit the form data to the server
                        // For this demo, just show a success message and reset the form
                        alert('Feedback submitted successfully! Thank you for your input.');
                        resetBtn.click();
                    });
                }
                
                // Edit and Delete Functionality
                const editButtons = document.querySelectorAll('.feedback-edit-btn');
                const deleteButtons = document.querySelectorAll('.feedback-delete-btn');
                const editModal = document.getElementById('editFeedbackModal');
                const closeModalButtons = document.querySelectorAll('.close-modal, .close-btn');
                const saveFeedbackBtn = document.querySelector('.save-feedback-btn');
                
                editButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        const feedbackId = this.getAttribute('data-id');
                        // In a real app, you would fetch the feedback data from the server
                        // For this demo, we'll just show the modal with pre-filled data
                        
                        // Show modal
                        if (editModal) {
                            editModal.style.display = 'block';
                            document.body.classList.add('modal-open');
                        }
                    });
                });
                
                deleteButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        const feedbackId = this.getAttribute('data-id');
                        // In a real app, you would send a delete request to the server
                        // For this demo, just show a confirmation dialog
                        if (confirm('Are you sure you want to delete this feedback?')) {
                            alert('Feedback deleted successfully');
                            // In a real app, you would remove the feedback item from the DOM or reload the list
                        }
                    });
                });
                
                // Close modal
                closeModalButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        if (editModal) {
                            editModal.style.display = 'none';
                            document.body.classList.remove('modal-open');
                        }
                    });
                });
                
                // Close modal when clicking outside
                window.addEventListener('click', function(e) {
                    if (e.target === editModal) {
                        editModal.style.display = 'none';
                        document.body.classList.remove('modal-open');
                    }
                });
                
                // Save edited feedback
                if (saveFeedbackBtn) {
                    saveFeedbackBtn.addEventListener('click', function() {
                        // In a real app, you would send the updated feedback to the server
                        // For this demo, just show a success message and close the modal
                        alert('Feedback updated successfully');
                        editModal.style.display = 'none';
                        document.body.classList.remove('modal-open');
                    });
                }
                
                // Filter functionality
                const filterSelect = document.querySelector('.filter-select');
                if (filterSelect) {
                    filterSelect.addEventListener('change', function() {
                        // In a real app, you would filter the feedback list based on the selected option
                        console.log('Filter changed:', this.value);
                    });
                }
            });
        </script>
    </body>
</html> 