$(function () {
    var icon = "fas fa-info-circle";
    var colours = {
        "Green" : "#1abc9c",
        "Red" : "#dc3545",
    };

    var sound = new Audio('alert.wav');
    sound.volume = 0.4;

    window.addEventListener('message', function (event) {
        
        if (event.data.action == 'notify') {
            var number = Math.floor((Math.random() * 1000) + 1);
            $('.notify-wrapper').append(`
            <div class="notify-div wrapper-${number}" style="border-left: 5px solid ${colours[event.data.type]}; display:none">
                <div class="align-items-baseline notify-title"><i class="${icon} fa-ms notify-icon" style="color: ${colours[event.data.type]}"></i>
                    <h5 class="text-uppercase notify-title-text" style="color: ${colours[event.data.type]}">${event.data.title}</h5>
                </div>
            <p class="text-break notify-main-text">${event.data.message}</p>
            </div>`)
            $(`.wrapper-${number}`).fadeIn("slow");
            sound.play();
            setTimeout(function () {
                $(`.wrapper-${number}`).fadeOut( "slow", function () {
                    $(`.wrapper-${number}`).remove()
                })
            }, event.data.time)
        }
    })
})
