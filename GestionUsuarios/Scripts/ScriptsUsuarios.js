$(document).ready(function () {
    $('#txtBuscar').on('keyup', function () {
        var texto = $(this).val().toLowerCase().trim();

        var filas = $('#' + gvUsuariosClientID + ' tbody tr').filter(function () {
            var tieneMensajeVacio = $(this).find('td > div.alert.alert-info').length > 0;
            var idTexto = $(this).find('td').eq(0).text().trim();
            var idValido = idTexto !== "" && !isNaN(idTexto) && Number(idTexto) > 0;

            return !tieneMensajeVacio && idValido;
        });

        var visibles = 0;

        filas.each(function () {
            var fila = $(this);
            var textoFila = fila.text().toLowerCase().trim();
            var mostrar = textoFila.indexOf(texto) > -1;
            fila.toggle(mostrar);
            if (mostrar) visibles++;
        });

        if (visibles === 0)
            $('#' + lblTotalRegistrosClientID).text('Sin registros que coincidan');
        else
            $('#' + lblTotalRegistrosClientID).text('Total de registros: ' + visibles);
    });

    $('.btnEliminarUsuario').click(function () {
        var idUsuario = $(this).data('id');
        var nombreUsuario = $(this).data('nombre');

        $('#' + hiddenIdUsuarioEliminarClientID).val(idUsuario);
        $('#nombreUsuarioEliminar').text(nombreUsuario);
    });

    var mensaje = $('#' + pnlMensajeClientID);
    if (mensaje.length && mensaje.text().trim().length > 0) {
        setTimeout(function () {
            mensaje.fadeOut('slow', function () {
                mensaje.html('');
                mensaje.show();
            });
        }, 3000);
    }

    $('#txtBuscar').trigger('keyup');
});
