<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h1 align="center">SqlPackage in a Docker image</h1>
  <p align="center">
    Just SqlPackage in a Docker image. It also includes SqlCmd.
    <br />
    <a href="https://github.com/Ark667/SqlPackage"><strong>Explore the docs »</strong></a>
    <br />    
    <a href="https://github.com/Ark667/SqlPackage/issues">Report Bug</a>
    ·
    <a href="https://github.com/Ark667/SqlPackage/issues">Request Feature</a>
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
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

[SqlPackage](https://docs.microsoft.com/en-us/sql/tools/sqlpackage?view=sql-server-ver15) is a Microsoft tool for importing and exporting bacpac and dacpac files from SQL Server.

This Docker image contains sqlpackage and is designed for when you want to run SqlPackage without installing it locally.

This image also contains `sqlcmd`. This makes this image very useful for running basic SQL Server tasks.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [Docker](https://docs.docker.com/engine/reference/commandline/build/)
* [SqlPackage](https://docs.microsoft.com/es-es/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15)
* [SqlCmd](https://docs.microsoft.com/es-es/sql/tools/sqlcmd-utility?view=sql-server-ver15)
* [Ubuntu](https://ubuntu.com/download)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

Run from current release.

```pwsh
docker run --rm -it ghcr.io/ark667/sqlpackage:master sqlpackage
```

Build the image locally.

```pwsh
docker build --tag sqlpackage .
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

Make a database backup. After execution, the bacpac file will be placed in sqlpackage folder of the current prompt.

```pwsh
docker run --rm -it --network host -v "$($PWD)/sqlpackage:/home" sqlpackage:dev sqlpackage /Action:Export /SourceServerName:"[host],[port]" /SourceDatabaseName:"[database]" /SourceUser:"[user]" /SourcePassword:"[password]" /TargetFile:"/home/backup.bacpac"
```

Make a database restore. The imported bacpac must be placed in sqlpackage folder of the current prompt, and database shoud not exists.

```pwsh
docker run --rm -it --network host -v "$($PWD)/sqlpackage:/home" ghcr.io/ark667/sqlpackage:master sqlpackage /Action:Import /TargetServerName:"[host],[port]" /TargetDatabaseName:"[database]" /TargetUser:"[user]" /TargetPassword:"[password]" /SourceFile:"/home/backup.bacpac"
```

Deploy a database schema. A folder containing the dacpac file is needed.

```pwsh
docker run --rm -it --network host -v "[dacpac_folder]:/home" ghcr.io/ark667/sqlpackage:master sqlpackage /Action:Publish /TargetServerName:"[host],[port]" /TargetDatabaseName:"[database]" /TargetUser:"[user]" /TargetPassword:"[password]" /SourceFile:"/home/[dacpac_file]"
```

Delete a database. Highly dangerous!

```pwsh
docker run --rm -it --network host ghcr.io/ark667/sqlpackage:master sqlcmd -S "[host],[port]" -U "[user]" -P "[password]" -Q "use [databsae];alter database [database] set single_user with rollback immediate;use master;drop database [database];"
```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Aingeru Medrano - [@AingeruBlack](https://twitter.com/AingeruBlack) <!-- - email@email_client.com -->

Project Link: [https://github.com/Ark667/SqlPackage](https://github.com/Ark667/SqlPackage)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Ark667/SqlPackage.svg?style=for-the-badge
[contributors-url]: https://github.com/Ark667/SqlPackage/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Ark667/SqlPackage.svg?style=for-the-badge
[forks-url]: https://github.com/Ark667/SqlPackage/network/members
[stars-shield]: https://img.shields.io/github/stars/Ark667/SqlPackage.svg?style=for-the-badge
[stars-url]: https://github.com/Ark667/SqlPackage/stargazers
[issues-shield]: https://img.shields.io/github/issues/Ark667/SqlPackage.svg?style=for-the-badge
[issues-url]: https://github.com/Ark667/SqlPackage/issues
[license-shield]: https://img.shields.io/github/license/Ark667/SqlPackage.svg?style=for-the-badge
[license-url]: https://github.com/Ark667/SqlPackage/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/aingeru/
[product-screenshot]: images/screenshot.png
