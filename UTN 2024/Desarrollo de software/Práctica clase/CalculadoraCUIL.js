function generarCuil(){
    let dni;
    dni = prompt("Ingrese su dni");
    cuenta = [3,2,7,6,5,4,3,2];
    do {
        genero = prompt("Ingrse su genero M-masculino F-femenino E-empresa").toUpperCase(); 
    } while (genero[0] != 'M' && genero[0] != 'F' && genero[0] != 'E');
    if (genero[0] == 'M'){
        X = 2;
        Y = 0;
    } else if (genero[0] == 'F'){
        X = 2;
        Y = 7;
    } else if (genero[0] == 'E'){
        X = 3;
        Y = 0;
    }
    total = 0;
    for (i = 0; i < dni.length; i++){
        total = total + parseInt(dni[i]) * cuenta[i]; 
    }
    total = total + (X * 5) + (Y * 4);    
    resto = Math.trunc(total / 11);
    resto = total - (resto*11);
    if (resto == 0){
        Z = 0;
    } else if (resto == 1) {
       X = 2;
       Y = 3;
        if (genero == 'M'){
            Z = 9;
       } else if (genero == 'F'){
            Z = 4;
       } 
    }else {
        Z = 11 - resto;
   }
    cuil = X.toString()+Y.toString()+'-'+dni+'-'+Z.toString();
    document.writeln(cuil);
}

generarCuil();