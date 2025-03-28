/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Ensure Chart.js runs after the page loads
document.addEventListener("DOMContentLoaded", function () {
    genViewChart();
});

function selectCard(card) {
    if (card.classList.contains('selected')) {
        return; // Do nothing if already selected
    }

    // Remove 'selected' class from all cards
    document.querySelectorAll('.cardcard').forEach(el => el.classList.remove('selected'));
    // Add 'selected' class to the clicked card
    card.classList.add('selected');
    changeChartDuration();
}

let visitorChartInstance = null;

function genViewChart(duration = 'month') {
    fetch("genViewChart?duration="+duration) // Fetch data from the Servlet
            .then(response => response.json()) // Convert response to JSON
            .then(data => {
                // Unique Visitor Line Chart
                const visitorCtx = document.getElementById('visitorChart');
                if (visitorCtx) {
                    if (visitorChartInstance !== null) {
                        visitorChartInstance.destroy();
                    }
                    visitorChartInstance = new Chart(visitorCtx, {
                        type: 'bar',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                    label: 'Total Login',
                                    data: data.data,
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 2,
                                    backgroundColor: 'rgba(54, 162, 235, 1)',
                                }]
                        },
                        options: {responsive: true}
                    });
                }
            })
}

function genLoginChart(duration = 'month') {
    fetch('genLoginChart?duration='+duration) // Fetch data from the Servlet
            .then(response => response.json()) // Convert response to JSON
            .then(data => {
                // Unique Visitor Line Chart
                const visitorCtx = document.getElementById('visitorChart');
                if (visitorCtx) {
                    if (visitorChartInstance !== null) {
                        visitorChartInstance.destroy();
                    }
                    visitorChartInstance = new Chart(visitorCtx, {
                        type: 'bar',
                        data: {
                            labels: data.labels,
                            datasets: [{
                                    label: 'Total Login',
                                    data: data.data,
                                    borderColor: 'rgba(54, 162, 235, 1)',
                                    borderWidth: 2,
                                    backgroundColor: 'rgba(54, 162, 235, 1)',
                                }]
                        },
                        options: {responsive: true}
                    });
                }
                console.log(data);
            })
}

function genSaleChart(duration = 'month') {
    fetch('genSaleChart?duration='+duration) // Fetch data from the Servlet
            .then(response => response.json()) // Convert response to JSON
            .then(data => {
                // Unique Visitor Line Chart
                const visitorCtx = document.getElementById('visitorChart');
                if (visitorCtx) {
                    if (visitorChartInstance !== null) {
                        visitorChartInstance.destroy();
                    }
                    let datasets = data.data.map(seller => ({
                            label: seller.name,
                            data: seller.sales,
                            borderColor: getRandomColor(),
                            borderWidth: 2,
                        }));

                    visitorChartInstance = new Chart(visitorCtx, {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: datasets,
                        },
                        options: {responsive: true}
                    });
                }
            })
}

function genTicketChart(duration = 'month') {
    fetch('genTicketChart?duration='+duration) // Fetch data from the Servlet
            .then(response => response.json()) // Convert response to JSON
            .then(data => {
                // Unique Visitor Line Chart
                const visitorCtx = document.getElementById('visitorChart');
                if (visitorCtx) {
                    if (visitorChartInstance !== null) {
                        visitorChartInstance.destroy();
                    }
                    let datasets = data.data.map(seller => ({
                            label: seller.name,
                            data: seller.sales,
                            borderColor: getRandomColor(),
                            borderWidth: 2,
                        }));

                    visitorChartInstance = new Chart(visitorCtx, {
                        type: 'line',
                        data: {
                            labels: data.labels,
                            datasets: datasets,
                        },
                        options: {responsive: true}
                    });
                }
            })
}

function getRandomColor(alpha = 1) {
    let r = Math.floor(Math.random() * 255);
    let g = Math.floor(Math.random() * 255);
    let b = Math.floor(Math.random() * 255);
    return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

function changeChartDuration(duration = 'month') {
    // Update active button
    document.querySelectorAll('.time-filter-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    document.getElementById(duration + 'Btn').classList.add('active');
    
    // Call the appropriate chart generation function based on which card is selected
    const selectedCard = document.querySelector('.cardcard.selected');
    
    if (selectedCard.classList.contains('viewChart')) {
        genViewChart(duration);
    } else if (selectedCard.classList.contains('loginChart')) {
        genLoginChart(duration);
    } else if (selectedCard.classList.contains('saleChart')) {
        genSaleChart(duration);
    } else if (selectedCard.classList.contains('ticketChart')) {
        genTicketChart(duration);
    }
}

// Modify the document.addEventListener to set the month button as active by default
document.addEventListener("DOMContentLoaded", function () {
    genViewChart();
    document.getElementById('monthBtn').classList.add('active');
});