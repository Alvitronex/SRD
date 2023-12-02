<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a style="color:white;" class="navbar-brand" href="index.php"><i class="fa-solid fa-store"></i> <b>SRD</b></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a style="color:white;" class="nav-link active" aria-current="page" href="index.php">Inicio</a>
        </li>
      </ul>

      <form action="./index.php" method="POST">
        <input type="hidden" value="1" name="off">
        <button href="" class="btn btn-danger BtnSalir">
          <i class="fa-solid fa-person-through-window"></i>
        </button>
      </form>
    </div>
  </div>
</nav>