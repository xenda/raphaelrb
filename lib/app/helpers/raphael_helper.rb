# Raphaelrb
module RaphaelHelper
  
    def render_chart(dom_id,chart_title,type="line")

      if type == "line"

      js =<<CODE
      <script type="text/javascript">

      function widget_function_#{dom_id} () {

         y1 = [], y2 = [] 
         for (var i = 0; i < 7; i++) {

            y1[i] =  parseInt((Math.random() * 35));
            y2[i] =  parseInt((Math.random() * 35));

          } 

         var r = Raphael("#{dom_id}");
         r.g.txtattr.font = "16px 'Fontin Sans', Fontin-Sans, sans-serif";

         r.g.text(300, 10, "#{chart_title}");

         // var lines = r.g.linechart(30, 50, 500, 220, [[5, 10, 15, 20, 25, 30, 35],[5, 10, 15, 20, 25, 30,35]],[[12, 32, 23, 15, 17, 27, 22], [5, 7, 20, 24, 25, 30,32]], {nostroke: false, axis: "0 0 1 1", symbol: "o"}).hoverColumn(function () {

          var lines = r.g.linechart(30, 50, 500, 220, [[5, 10, 15, 20, 25, 30, 35],[5, 10, 15, 20, 25, 30,35]],[y1, y2], {nostroke: false, axis: "0 0 1 1", symbol: "o"}).hoverColumn(function () {

         this.tags = r.set();
            for (var i = 0, ii = this.y.length; i < ii; i++) {
                this.tags.push(r.g.tag(this.x, this.y[i], this.values[i], 160, 10).insertBefore(this).attr([{fill: "#ff3"}, {fill: this.symbols[i].attr("fill")}]));
            }
        }, function () {
            this.tags && this.tags.remove();
        });
        lines.lines[0].animate({"stroke-width": 3}, 1000);
        lines.lines[1].animate({"stroke-width": 4}, 2000);                   
    //    lines.symbols[0][1].animate({fill: "#f00"}, 1000);
    //    lines.symbols[1][1].animate({fill: "#fF0"}, 1000);

             /// RAPHAEL CHARTS
        }

        </script>


CODE

    elsif type == "carrusel"

      js =<<CODE

      <script type="text/javascript">

      function widget_function_#{dom_id} () {

      var r = Raphael("#{dom_id}", 620, 250),
                 e = [],
                 clr = [],
                 months = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"],
                 values = [],
                 now = 0,
                 month = r.text(310, 27, months[now]).attr({stroke: "none", "font": '15px "Fontin Sans", Fontin-Sans, Arial'}),
                 rightc = r.circle(364, 27, 10).attr({fill: "#fff"}),
                 right = r.path("M360,22l10,5 -10,5z").attr({fill: "#000"}),
                 leftc = r.circle(256, 27, 10).attr({fill: "#fff"}),
                 left = r.path("M260,22l-10,5 10,5z").attr({fill: "#000"}),
                 c = r.path("M0,0").attr({fill: "none", "stroke-width": 3}),
                 bg = r.path("M0,0").attr({stroke: "none", opacity: .3}),
                 dotsy = [];
             function randomPath(length, j) {
                 var path = "",
                     x = 10,
                     y = 0;
                 dotsy[j] = dotsy[j] || [];
                 for (var i = 0; i < length; i++) {
                     dotsy[j][i] = Math.round(Math.random() * 200);
                     if (i) {
                         path += "C" + [x + 10, y, (x += 20) - 10, (y = 240 - dotsy[j][i]), x, y];
                     } else {
                         path += "M" + [10, (y = 240 - dotsy[j][i])];
                     }
                 }
                 return path;
             }
             for (var i = 0; i < 12; i++) {
                 values[i] = randomPath(30, i);
                 clr[i] = Raphael.getColor(1);
             }
             c.attr({path: values[0], stroke: clr[0]});
             bg.attr({path: values[0] + "L590,250 10,250z", fill: clr[0]});
             month.attr({fill: clr[0]});
             var animation = function () {
                 var time = 500;
                 if (now == 12) {
                     now = 0;
                 }
                 if (now == -1) {
                     now = 11;
                 }
                 c.animate({path: values[now], stroke: clr[now]}, time, "<>");
                 bg.animate({path: values[now] + "L590,250 10,250z", fill: clr[now]}, time, "<>");
                 month.attr({text: months[now], fill: clr[now]});
             };
             rightc.node.onclick = right.node.onclick = function () {
                 now++;
                 animation();
             };
             leftc.node.onclick = left.node.onclick = function () {
                 now--;
                 animation();
             };
             document.onclicks = function () {
                 var path = r.parsePathString(values[now]),
                     x = path[1][5] - 30,
                     y = path[1][6];
                 path = r.pathToRelative(path);
                 path[1][0] = "m";
                 path[1].splice(1, 5, 0);
                 var newvalue = Math.round(Math.random() * 200) - 100;
                 path = path.join(",") + "c10,0 10," + newvalue + " 20," + newvalue;
                 c.animate({path: path}, 2000);
                 r.safari();
             };

           };

      </script>

CODE

    else

      js =<<CODE

      <script type="text/javascript">





      Raphael.fn.drawGrid = function (x, y, w, h, wv, hv, color) {
          color = color || "#000";
          var path = ["M", x, y, "L", x + w, y, x + w, y + h, x, y + h, x, y],
              rowHeight = h / hv,
              columnWidth = w / wv;
          for (var i = 1; i < hv; i++) {
              path = path.concat(["M", x, y + i * rowHeight, "L", x + w, y + i * rowHeight]);
          }
          for (var i = 1; i < wv; i++) {
              path = path.concat(["M", x + i * columnWidth, y, "L", x + i * columnWidth, y + h]);
          }
          return this.path(path.join(",")).attr({stroke: color});
      };

      $(document).ready(function(){    

          $("#data").css({
              position: "absolute",
              left: "-9999em",
              top: "-9999em"
          });

    });    

      function widget_function_#{dom_id} () {
          // Grab the data
          var labels = [],
              data = [];
          $("#data tfoot th").each(function () {
              labels.push($(this).html());
          });
          $("#data tbody td").each(function () {
              data.push($(this).html());
          });

          // Draw
          var width = 800,
              height = 250,
              leftgutter = 30,
              bottomgutter = 20,
              topgutter = 20,
              colorhue = .6 || Math.random(),
              color = "hsb(" + [colorhue, 1, .75] + ")",
              r = Raphael("#{dom_id}", width, height),
              txt = {font: '12px Fontin-Sans, Arial', fill: "#fff"},
              txt1 = {font: '10px Fontin-Sans, Arial', fill: "#fff"},
              txt2 = {font: '12px Fontin-Sans, Arial', fill: "#000"},
              X = (width - leftgutter) / labels.length,
              max = Math.max.apply(Math, data),
              Y = (height - bottomgutter - topgutter) / max;
          r.drawGrid(leftgutter + X * .5, topgutter, width - leftgutter - X, height - topgutter - bottomgutter, 10, 10, "#333");
          var path = r.path().attr({stroke: color, "stroke-width": 4, "stroke-linejoin": "round"}),
              bgp = r.path().attr({stroke: "none", opacity: .3, fill: color}).moveTo(leftgutter + X * .5, height - bottomgutter),
              frame = r.rect(10, 10, 100, 40, 5).attr({fill: "#000", stroke: "#474747", "stroke-width": 2}).hide(),
              label = [],
              is_label_visible = false,
              leave_timer,
              blanket = r.set();
          label[0] = r.text(60, 10, "24 clicks").attr(txt).hide();
          label[1] = r.text(60, 40, "22 Octubre 2009").attr(txt1).attr({fill: color}).hide();

          for (var i = 0, ii = labels.length; i < ii; i++) {
              var y = Math.round(height - bottomgutter - Y * data[i]),
                  x = Math.round(leftgutter + X * (i + .5)),
                  t = r.text(x, height - 6, labels[i]).attr(txt).toBack();
              bgp[i == 0 ? "lineTo" : "cplineTo"](x, y, 10);
              path[i == 0 ? "moveTo" : "cplineTo"](x, y, 10);
              var dot = r.circle(x, y, 5).attr({fill: color, stroke: "#000"});
              blanket.push(r.rect(leftgutter + X * i, 0, X, height - bottomgutter).attr({stroke: "none", fill: "#fff", opacity: 0}));
              var rect = blanket[blanket.length - 1];
              (function (x, y, data, lbl, dot) {
                  var timer, i = 0;
                  $(rect.node).hover(function () {
                      clearTimeout(leave_timer);
                      var newcoord = {x: +x + 7.5, y: y - 19};
                      if (newcoord.x + 100 > width) {
                          newcoord.x -= 114;
                      }
                      frame.show().animate({x: newcoord.x, y: newcoord.y}, 200 * is_label_visible);
                      label[0].attr({text: data + " hit" + ((data % 10 == 1) ? "" : "s")}).show().animateWith(frame, {x: +newcoord.x + 50, y: +newcoord.y + 12}, 200 * is_label_visible);
                      label[1].attr({text: lbl + " Octubre 2009"}).show().animateWith(frame, {x: +newcoord.x + 50, y: +newcoord.y + 27}, 200 * is_label_visible);
                      dot.attr("r", 7);
                      is_label_visible = true;
                  }, function () {
                      dot.attr("r", 5);
                      leave_timer = setTimeout(function () {
                          frame.hide();
                          label[0].hide();
                          label[1].hide();
                          is_label_visible = false;
                          // r.safari();
                      }, 1);
                  });
              })(x, y, data[i], labels[i], dot);
          }
          bgp.lineTo(x, height - bottomgutter).andClose();
          frame.toFront();
          label[0].toFront();
          label[1].toFront();
          blanket.toFront();
      };  

      </script>


CODE

    end

      load_code =<<CODE

       <script type="text/javascript">
      // 
      //   if (window.addEventListener) // W3C standard
      //  {
      //     window.addEventListener('load', widget_function, false); // NB **not** 'onload'
      //   } 
      //   else if (window.attachEvent) // Microsoft
      //  {
      //    window.attachEvent('onload', widget_function);
      //  }
      //
        $(window).load(widget_function_#{dom_id} );

        </script>



CODE

    content_for :javascript do
      js + load_code
    end

    end
  

end