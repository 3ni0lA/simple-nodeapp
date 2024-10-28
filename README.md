# Simple Node.js Application

## Overview

This repository contains a simple Node.js application designed to demonstrate basic web server functionality. The application serves as an introductory project for learning Node.js and its core features.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Basic Web Server**: The application runs a web server using Node.js and Express.
- **RESTful API**: Implements a simple API with GET and POST methods.
- **JSON Response**: Returns data in JSON format.
- **Middleware**: Demonstrates the use of middleware for request handling.

## Technologies Used

- **Node.js**: JavaScript runtime for building the server-side application.
- **Express**: Web framework for Node.js that simplifies server creation.
- **Nodemon**: Development tool that automatically restarts the server when file changes are detected.
- **Body-parser**: Middleware for parsing incoming request bodies in a middleware before your handlers, available under the `req.body` property.

## Installation

Follow these steps to set up the application on your local machine:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/3ni0lA/simple-nodeapp.git
   cd simple-nodeapp

2. Navigate to the project directory in your terminal.
3. Run `npm install` to install the necessary dependencies.
4. Start the server using `npm start`.
5. The server will be running at `http://localhost:3000/api/greeting`.

