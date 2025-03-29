/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener("DOMContentLoaded", function () {
    genTicketChart();
    genTicketTrainChart();
    genSellerRevenue();
});

function genTicketChart(duration = 'week') {
    fetch("genTicketSellerChart?duration=" + duration)
        .then(response => response.json())
        .then(servletData => {
            const labels = servletData.labels;
            const data = servletData.data;

            // Get chart context
            const ticketCtx = document.getElementById('ticketChart').getContext('2d');

            // If chart exists, destroy it before creating a new one
            if (window.ticketChart && typeof window.ticketChart.destroy === 'function') {
                window.ticketChart.destroy();
            }
            
            

            // Create new chart
            window.ticketChart = new Chart(ticketCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Tickets',
                        data: data,
                        borderColor: '#4361ee',
                        backgroundColor: 'rgba(67, 97, 238, 0.1)',
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        })
        .catch(error => console.error("Error fetching ticket data:", error));
}

document.querySelectorAll('#ticketTimeToggle .btn').forEach(button => {
    button.addEventListener('click', function () {
        document.querySelectorAll('#ticketTimeToggle .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        this.classList.add('active');

        const period = this.getAttribute('data-period');
        genTicketChart(period); // Call the function to fetch data and update the chart
    });
});

function genTicketTrainChart() {
    fetch("genTicketTrainChart") // Fetch data from the Servlet
        .then(response => response.json()) // Convert response to JSON
        .then(servletData => {
            const labels = servletData.labels;
            const data = servletData.data;

            // Get chart context
            const demographicsCtx = document.getElementById('demographicsChart').getContext('2d');

            // Check if the chart exists and destroy it if necessary
            if (window.demographicsChart && typeof window.demographicsChart.destroy === 'function') {
                window.demographicsChart.destroy();
            }

            // Create the chart
            window.demographicsChart = new Chart(demographicsCtx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: data,
                        backgroundColor: [
                            '#4361ee',
                            '#3a0ca3',
                            '#7209b7',
                            '#f72585'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    },
                    cutout: '70%'
                }
            });
        })
        .catch(error => console.error("Error fetching demographics data:", error));
}

function genSellerRevenue(duration = 'week') {
    fetch("genSellerRevenue?duration=" + duration) // Fetch data from the Servlet
        .then(response => response.json()) // Convert response to JSON
        .then(servletData => {
            const labels = servletData.labels;
            const data = servletData.data;

            // Get chart context
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');

            // Check if the chart exists and destroy it if necessary
            if (window.revenueChart && typeof window.revenueChart.destroy === 'function') {
                window.revenueChart.destroy();
            }

            // Create the chart
            window.revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Revenue',
                        data: data,
                        borderColor: '#2a9d8f',
                        backgroundColor: 'rgba(42, 157, 143, 0.1)',
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false
                            },
                            ticks: {
                                callback: function (value) {
                                    return '$' + value.toLocaleString();
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        })
        .catch(error => console.error("Error fetching revenue data:", error));
}

document.querySelectorAll('#revenueTimeToggle .btn').forEach(button => {
    button.addEventListener('click', function () {
        document.querySelectorAll('#revenueTimeToggle .btn').forEach(btn => {
            btn.classList.remove('active');
        });
        this.classList.add('active');

        const period = this.getAttribute('data-period');
        genSellerRevenue(period); // Fetch and update chart based on selected period
    });
});