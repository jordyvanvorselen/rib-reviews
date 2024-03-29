<a name="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/jordyvanvorselen/rib-reviews">
    <img src="frontend/assets/images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Rib Reviews</h3>

  <p align="center">
    Serverless Next.js backend + Flutter mobile app that allows users to rate their favourite restaurants.
    <br />
    <a href="https://github.com/jordyvanvorselen/rib-reviews"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://rib-reviews.web.app">View Live Version</a>
    ·
    <a href="https://github.com/jordyvanvorselen/rib-reviews/issues">Report Bug</a>
    ·
    <a href="https://github.com/jordyvanvorselen/rib-reviews/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

Because we frequently visited grill restaurants with a group of colleagues to compare their spareribs, we started _The Eat Guild_. This app makes it possible for all members to review these restaurants. It also acts as a suggestion pipeline, so it's easier to track where we want to go next.

<a href="https://github.com/jordyvanvorselen/rib-reviews">
  <img src=".screenshots/login.png" alt="Login screenshot" width="200" height="400">
  <img src=".screenshots/timeline.png" alt="Timeline screenshot" width="200" height="400">
  <img src=".screenshots/reviews.png" alt="Reviews screenshot" width="200" height="400">
  <img src=".screenshots/review_alert.png" alt="Review alert screenshot" width="200" height="400">
  <br>
  <br>
</a>

Rib reviews is a Flutter mobile app backed by a Serverless Next.js backend hosted on Vercel. It uses MongoDB Atlas as a database and Firebase for authentication. The app is also integrated with Slack using a bolt-js slackbot. The slackbot allows users to suggest new restaurants and plan events.

<a href="https://github.com/jordyvanvorselen/rib-reviews">
  <img src=".screenshots/slackbot.PNG" alt="Slackbot screenshot" width="200" height="400">
  <br>
  <br>
</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

- [![Next][next.js]][next-url]
- [![Bolt for Slack][bolt]][bolt-url]
- [![Flutter][flutter]][flutter-url]
- [![Vercel][vercel]][vercel-url]
- [![MongoDB][mongo]][mongo-url]
- [![Firebase][firebase]][firebase-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

This project is set up in three main folders. The `frontend` folder contains the Flutter mobile app, the `backend` folder contains the Next.js backend and the `slackbot` folder contains the bolt-js slackbot. They all contain their own respective setup instructions.

- Click [here](./frontend/README.md) to read more about the technical setup of the **mobile app**.
- Click [here](./backend/README.md) to read more about the technical setup of the **backend**.
- Click [here](./slackbot/README.md) to read more about the technical setup of the **slackbot**.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

- [x] Plan events
- [x] Rate restaurants
- [x] React on restaurant ratings using emoji's
- [x] Slackbot to suggest new restaurants
- [ ] Vote for suggested restaurants
- [x] Plan events using Slackbot
- [ ] Notify users about upcoming events

See the [open issues](https://github.com/jordyvanvorselen/rib-reviews/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/amazing-feature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the GPLv3 License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Jordy van Vorselen - [@jordyvanvorselen](https://twitter.com/jordyvanvorselen) - jordyvanvorselen@gmail.com

Project Link: [https://github.com/jordyvanvorselen/rib-reviews](https://github.com/github_username/repo_name)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/jordyvanvorselen/rib-reviews.svg?style=for-the-badge
[contributors-url]: https://github.com/jordyvanvorselen/rib-reviews/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jordyvanvorselen/rib-reviews.svg?style=for-the-badge
[forks-url]: https://github.com/jordyvanvorselen/rib-reviews/network/members
[stars-shield]: https://img.shields.io/github/stars/jordyvanvorselen/rib-reviews.svg?style=for-the-badge
[stars-url]: https://github.com/jordyvanvorselen/rib-reviews/stargazers
[issues-shield]: https://img.shields.io/github/issues/jordyvanvorselen/rib-reviews.svg?style=for-the-badge
[issues-url]: https://github.com/jordyvanvorselen/rib-reviews/issues
[license-shield]: https://img.shields.io/github/license/jordyvanvorselen/rib-reviews.svg?style=for-the-badge&license=agplv3
[license-url]: https://github.com/jordyvanvorselen/rib-reviews/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/jordy-van-vorselen
[next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[next-url]: https://nextjs.org/
[flutter]: https://img.shields.io/badge/flutter-000000?style=for-the-badge&logo=flutter&logoColor=blue
[flutter-url]: https://flutter.dev/
[mongo]: https://img.shields.io/badge/mongodb-000000?style=for-the-badge&logo=mongodb&logoColor=green
[mongo-url]: https://www.mongodb.com/
[bolt]: https://img.shields.io/badge/bolt%20for%20slack-000000?style=for-the-badge&logo=slack&logoColor=red
[bolt-url]: https://github.com/slackapi/bolt-js
[vercel]: https://img.shields.io/badge/vercel-000000?style=for-the-badge&logo=vercel&logoColor=white
[vercel-url]: https://vercel.com/
[firebase]: https://img.shields.io/badge/firebase-000000?style=for-the-badge&logo=firebase&logoColor=orange
[firebase-url]: https://firebase.google.com/
