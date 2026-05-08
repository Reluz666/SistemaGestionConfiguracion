// Funciones compartidas para el sistema de Gestion de Configuracion

function MostrarMensaje() {
    var mensaje = document.getElementById("__mensaje").value;
    if (mensaje != "") {
        alert(mensaje);
        var pagina = document.getElementById("__pagina").value;
        if (pagina !== "") location.href = pagina;
    }
}

function Confirmar(men) {
    if (!confirm(men)) return false;
    return true;
}

function SoloNumeros() {
    if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false;
}

function SoloLetrasMinusculas() {
    if (!((event.keyCode >= 97 && event.keyCode <= 122) || event.keyCode == 32
        || event.keyCode == 193 || event.keyCode == 201 || event.keyCode == 205
        || event.keyCode == 209 || event.keyCode == 211 || event.keyCode == 218
        || event.keyCode == 220 || event.keyCode == 241)) event.returnValue = false;
}

function CambiaLetraMayuscula(Caja) {
    document.getElementById(Caja).value = document.getElementById(Caja).value.toUpperCase();
}