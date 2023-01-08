# Rib Reviews Backend

This backend uses Next.js to create a REST API that can be used by the mobile app located in the `../frontend` folder.

## Getting Started

The application is automatically deployed to [Vercel](https://vercel.com/) upon pushing. Creating a pull request will trigger the creation of an online preview version. Merging the pull request to `master` will automatically deploy to production.

### Prerequisites

To set up this project you need Node.js `v18.12.1` and npm `8.19.2`. You can install these following the instructions [here](https://nodejs.org/en/).

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/jordyvanvorselen/rib-reviews.git
   ```
2. Change into the backend directory
   ```sh
   cd backend
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Copy the `env.example` file:
   ```sh
   cp env.example .env
   ```
5. Fill in the secrets. You need to create a MongoDB database. (You can host a _free_ MongoDB instance [in the cloud](https://www.mongodb.com/atlas/database))

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Running the project

1. Run the following command
   ```sh
   npm run dev
   ```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

[API routes](https://nextjs.org/docs/api-routes/introduction) can be accessed on `http://localhost:3000/api/<resource>`. These endpoints can be edited in `pages/api/<resource>.ts`.

The `pages/api` directory is mapped to `/api/*`. Files in this directory are treated as [API routes](https://nextjs.org/docs/api-routes/introduction) instead of React pages.

<!-- ROADMAP -->

## Learn more about Next.js

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js/) - your feedback and contributions are welcome!

## Lean more about Vercel

The easiest way to deploy a Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out the [Next.js deployment documentation](https://nextjs.org/docs/deployment) for more details.
