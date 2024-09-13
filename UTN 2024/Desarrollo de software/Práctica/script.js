console.log('Hola Mundo!');

window.addEventListener('load', () => {                     /*en el momoento que termina de cargar toda la pagina web, recien ahi se puede apretar enviar */
    const submitButton = document.querySelector('#submit'); /*La clase se identifica con .class y el id se identifica con #id  */
    submitButton.addEventListener('click', (event) => {
        event.preventDefault();
        const name = document.querySelector('#name').value;
        const email = document.querySelector('#email').value;
        const message = document.querySelector('#message').value;

        if (name !== '' && email !== '' && message !== ''){
            //ok
            document.querySelector('#user-name').innerHTML = name;
            document.querySelector('#user-email').innerHTML = email;
            document.querySelector('#user-message').innerHTML = message;
        } else {
            //error
            document.querySelector('#error').classList.add('show-error');
        }
    });
});