<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuenta Administrador</title>
    <!-- Se inserta la foto del logo de la empresa -->
    <link rel="shortcut icon" type="image/png" href="../assets/images/logos_voluntariapp/logo_VOLUNTARIAPP.png" />
    <link rel="stylesheet" href="../assets/css/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/css/register.css">
    <link rel="stylesheet" href="{pageContext.request.contextPath}https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
</head>

<body>
    <div class="text-md-start p-4">
        <img src="../assets/images/logos_voluntariapp/logo_extend.png" style="width:200px" alt="">
    </div>
    <div class="container-fluid d-flex align-items-center justify-content-center">
        <div class="container bg-white rounded shadow">
            <!-- shadow -->

            <div class="row align-items-stretch">
                <div class="col bg-white p-5 rounded-end">
                    <h3 class="fw-bold text-center ">Crear una cuenta de VoluntariApp</h3>
                    <h4 class="fw-bold text-center colorcito_azulito">Administrador</h4>
                    <br>
                    <!-- Register -->
                    <form class="needs-validation" action="add-admin" method="post">
                        <div class="row">
                            <div class="col-md-0 mb-4">
                                <div class="form-floating">
                                    <input type="text" id="nombre" class="form-control" placeholder="Nombre" required>
                                    <label for="nombre">Nombre</label>
                                </div>
                            </div>
                            <div class="col-md-0 mb-4">
                                <div class="form-floating">
                                    <input type="email" id="email" class="form-control" placeholder="Email" required>
                                    <label for="email">Email</label>
                                </div>
                            </div>
                            <div class="col-md-0 mb-4">
                                <div class="form-floating form-control-icon">
                                    <input type="password" id="password" class="form-control" placeholder="Contraseña"
                                        required>
                                    <label for="password">Contraseña</label>
                                    <div class="password-toggle" onclick="togglePasswordVisibility('password')">
                                        <i id="password-toggle-icon" class="bi bi-eye-slash"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-0 mb-4">
                                <div class="form-floating form-control-icon">
                                    <input type="password" id="confirm_password" class="form-control"
                                        placeholder="Confirmar Contraseña" required>
                                    <label for="confirm_password">Confirmar Contraseña</label>
                                    <div class="password-toggle" onclick="togglePasswordVisibility('confirm_password')">
                                        <i id="confirm-password-toggle-icon" class="bi bi-eye-slash"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-grid">
                            <!--
                            <button type="submit" class="btn btn-primary" onclick="return validateForm()">Crear cuenta</button>
                            -->
                            <button type="submit" class="btn btn-primary">Crear cuenta</button>

                        </div>
                        <br>
                        <div class="text-center">
                            <span>¿Ya tienes una cuenta? <a href="../index.jsp">Inicia sesión</a></span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="../assets/js/bootstrap.bundle.min.js"></script>
    <script src="../assets/js/register_login.js"></script>
    <script>
        (function () {
            'use strict'
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.querySelectorAll('.needs-validation')
            // Loop over them and prevent submission
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })();
    </script>
</body>

</html>