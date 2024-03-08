<template>
    <h1> Pipipitchu Movies</h1>
    <h4> {{API_URL}} </h4>

    <div class="movies-box">
        <div class="movie-item" v-for="movie in movies" :key="movie.id">
            <h5>{{movie.id}} - {{ movie.title }}</h5>
            <button @click="deleteMovie(movie.id)"> X </button>
        </div>
    </div>
    
    <input type="text"
        v-model="title"
        placeholder="Movie Title"
        class="title-input" />

    <button @click="addMovie"> Add </button>
</template>

<script setup>
    import { ref, onMounted } from 'vue';

    const API_URL = import.meta.env.VITE_API_URL + "/movies";
    const movies = ref([])
    const title = ref('')
    const movie_id= ref(0)

    onMounted(async() => {
        const res = await fetch(API_URL)
        movies.value = await res.json()
        console.log('Movies:', movies.value);
    })

    const addMovie = async() => {
        const res = await fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                title: title.value,
            })
        })

        const data = await res.json()

        movies.value.push(data)
        title.value = ''
        movie_id.value = 0;
    }

    const deleteMovie = async(id) => {
        await fetch (`${API_URL}/${id}`, {
            method: 'DELETE'
        })
        movies.value = movies.value.filter(movies => movies.id != id)
    }
</script>

<style scooped>
.title-input{
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    background-color: #b6b6b6;
    color: #111;
    border-radius: 10px;
    resize: vertical;
}

.movies-box {
    width: 100%;
    padding: 10px 0px;
    margin: 0px 0px;
    box-sizing: border-box;
    background-color: #323232;
    color: #bfbebe;
    border-radius: 15px;
    resize: vertical;
}

.movie-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 0px 50px;
}
</style>