
/*Função Pai de Mascaras*/
function Mascara(o, f) {
    v_obj = o
    v_fun = f
    setTimeout("execmascara()", 1)
}

/*Função que Executa os objetos*/
function execmascara() {
    v_obj.value = v_fun(v_obj.value)
}

/*Função que Determina as expressões regulares dos objetos*/
function leech(v) {
    v = v.replace(/o/gi, "0")
    v = v.replace(/i/gi, "1")
    v = v.replace(/z/gi, "2")
    v = v.replace(/e/gi, "3")
    v = v.replace(/a/gi, "4")
    v = v.replace(/s/gi, "5")
    v = v.replace(/t/gi, "7")
    return v
}

/*Função que permite apenas numeros*/
function Integer(v) {
    return v.replace(/\D/g, "")
}

/*Função que padroniza telefone (11) 4184-1241*/
function Telefone(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/^(\d\d)(\d)/g, "($1) $2")
    v = v.replace(/(\d{4})(\d)/, "$1-$2")
    return v
}

/*Função que padroniza telefone (11) 14184-1241*/
function Celular(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/^(\d\d)(\d)/g, "($1) $2")
    v = v.replace(/(\d{5})(\d)/, "$1-$2")
    return v
}

/*Função que padroniza telefone (11) 41841241*/
function TelefoneCall(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/^(\d\d)(\d)/g, "($1) $2")
    return v
}

/*Função que padroniza CPF*/
function Cpf(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/(\d{3})(\d)/, "$1.$2")
    v = v.replace(/(\d{3})(\d)/, "$1.$2")

    v = v.replace(/(\d{3})(\d{1,2})$/, "$1-$2")
    return v
}

/*Função que padroniza CEP*/
function Cep(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/^(\d{5})(\d)/, "$1-$2")
    return v
}

/*Função que padroniza RG*/
function Rg(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/(\d{2})(\d)/, "$1.$2")
    v = v.replace(/(\d{3})(\d)/, "$1.$2")

    v = v.replace(/(\d{3})(\d{1,1})$/, "$1-$2")
    return v
}

/*Função que padroniza CNPJ*/
function Cnpj(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/^(\d{2})(\d)/, "$1.$2")
    v = v.replace(/^(\d{2})\.(\d{3})(\d)/, "$1.$2.$3")
    v = v.replace(/\.(\d{3})(\d)/, ".$1/$2")
    v = v.replace(/(\d{4})(\d)/, "$1-$2")
    return v
}

/*Função que permite apenas numeros Romanos*/
function Romanos(v) {
    v = v.toUpperCase()
    v = v.replace(/[^IVXLCDM]/g, "")

    while (v.replace(/^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/, "") != "")
        v = v.replace(/.$/, "")
    return v
}

/*Função que padroniza o Site*/
function Site(v) {
    v = v.replace(/^http:\/\/?/, "")
    dominio = v
    caminho = ""
    if (v.indexOf("/") > -1)
        dominio = v.split("/")[0]
    caminho = v.replace(/[^\/]*/, "")
    dominio = dominio.replace(/[^\w\.\+-:@]/g, "")
    caminho = caminho.replace(/[^\w\d\+-@:\?&=%\(\)\.]/g, "")
    caminho = caminho.replace(/([\?&])=/, "$1")
    if (caminho != "")
        dominio = dominio.replace(/\.+$/, "")
    v = "http://" + dominio + caminho
    return v
}

/*Função que padroniza DATA*/
function Data(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/(\d{2})(\d)/, "$1/$2")
    v = v.replace(/(\d{2})(\d)/, "$1/$2")
    return v
}

/*Função que padroniza Hora*/
function Hora(v) {
    v = v.replace(/\D/g, "")
    v = v.replace(/(\d{2})(\d)/, "$1:$2")
    return v
}

/*Função que padroniza valor monétario*/
function Valor(v) {
    /*
    v = v.replace(/(\d{3})(\d)/g, "$1,$2")
    v = v.replace(/\D/g, ""); //Remove tudo o que não é dígito
    v = v.replace(/^([0-9]{3}\.?){3}-[0-9]{2}$/, "$1.$2");
    v = v.replace(/(\d)(\d{2})$/, "$1,$2"); //Coloca ponto antes dos 2 últimos digitos

    */
    v = v.replace(/\D/g, "") // permite digitar apenas numero 
    v = v.replace(/(\d{1})(\d{14})$/, "$1.$2") // coloca ponto antes dos ultimos digitos 
    v = v.replace(/(\d{1})(\d{11})$/, "$1.$2") // coloca ponto antes dos ultimos 11 digitos 
    v = v.replace(/(\d{1})(\d{8})$/, "$1.$2") // coloca ponto antes dos ultimos 8 digitos 
    v = v.replace(/(\d{1})(\d{5})$/, "$1.$2") // coloca ponto antes dos ultimos 5 digitos 
    v = v.replace(/(\d{1})(\d{1,2})$/, "$1,$2") // coloca virgula antes dos ultimos 2 digitos 

    return v;
}

function moveToEnd(elm) {
    var value = elm.value;
    elm.value = '';
    elm.focus();
    elm.value = value;
}

function mascara(elm, event) {
    var valor = elm.value;
    var isLetter = function (code) {
        return (code >= 65 && code <= 90);
    };
    var code = event.wich || event.keyCode;
    
    if (valor.length <= 3) {
        if (isLetter(code)) {
            valor = valor.toUpperCase();
        } else {
            if (valor.length > 0 && code >= 48) {
                valor = valor.substr(0, valor.length - 1);
            }
        }
    }
    if (valor.length == 3 && isLetter(valor.charCodeAt(2))) {
        valor += '-';
    }
    if (valor.length > 4 && valor.length <= 8) {
        if (isNaN(String.fromCharCode(code)) && code >= 48) {
            valor = valor.substr(0, valor.length - 1);
        }
    }
    if (valor.length > 8) {
        valor = valor.substr(0, 8);
    }
    elm.value = valor;
}
