$(".st").on('click',function () {

    var name = $(".name",this).text()
    var line = $(".line",this).text()
    console.log(`name:${name},line:${line}`)
    $.ajax({
        url: '/next',
        type: 'get',
        dataType: 'json',
        data: {
            name: name,
            line: line
        }

    })
        .done(function (base_json) {
            var json = base_json
            console.log(json)
            var next_name = json["next"]
            console.log(next_name)
            $(".next_name").text(next_name)

        })
})