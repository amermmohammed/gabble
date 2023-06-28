// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


// Function to toggle theme and icons
function toggleTheme() {
    const root = document.documentElement;
    const moonIcon = document.querySelector('.fa-moon');
    const sunIcon = document.querySelector('.fa-sun');

    // Toggle visibility of moon and sun icons
    moonIcon.classList.toggle('d-none');
    sunIcon.classList.toggle('d-none');

    // Toggle root classes
    root.classList.toggle('light-theme');
    root.classList.toggle('dark-theme');

    // Store theme preference in local storage
    const isDarkTheme = root.classList.contains('dark-theme');
    localStorage.setItem('theme', isDarkTheme ? 'dark' : 'light');
}

// Add click listener to the theme toggle button
const themeToggleBtn = document.getElementById('theme-toggle');
themeToggleBtn.addEventListener('click', toggleTheme);

// Retrieve theme preference from local storage
const savedTheme = localStorage.getItem('theme');
if (savedTheme === 'dark') {
    toggleTheme(); // If dark theme is saved, apply it on page load
}
