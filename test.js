// fetch('https://dummyjson.com/users').then(res => console.log(res.json()));

// fetch('https://dummyjson.com/users')
// .then(response => {
//     // This returns a new Promise
//     return response.json();
//   })
//   .then(data => {
//     // How would you log the final data here?
//     console.log(data);
//   })
//   .catch(error => {
//     console.error('Fetch Error:', error);
//   });

async function fetchData() {
    try {
        let response = await fetch("https://dummyjson.com/users");
        if (!response.ok) {
            throw new Error("Failed to fetch data");
        }
        let data = await response.json();
        console.log(data);
    } catch (error) {
        console.error("Fetch Error:", error);
    }
}

fetchData();
