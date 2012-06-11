/**
 *  ueditor完整配置项
 *  可以在这里配置整个编辑器的特性
 */

(function () {
    var tmp = window.location.pathname,
            URL = window.UEDITOR_HOME_URL||tmp.substr(0,tmp.lastIndexOf("\/")+1).replace("_examples/","").replace("website/","");//这里你可以配置成ueditor目录在您网站的相对路径或者绝对路径（指以http开头的绝对路径）
    UEDITOR_CONFIG = {
        UEDITOR_HOME_URL:URL,                                          //为editor添加一个全局路径
        //工具栏上的所有的功能按钮和下拉框，可以在new编辑器的实例时选择自己需要的从新定义
        toolbars:[
            ['FullScreen', 'Source', '|', 'Undo', 'Redo', '|',
                'Bold', 'Italic', 'Underline', 'StrikeThrough', 'RemoveFormat', 
                '|', 'PastePlain', '|', 'ForeColor', 'BackColor', 'FontSize', 'Preview'
            ]
        ],
        //当鼠标放在工具栏上时显示的tooltip提示
        labelMap:{
            'undo':'撤销', 'redo':'重做', 'bold':'加粗', 'source':'源代码',
            'italic':'斜体', 'underline':'下划线', 'strikethrough':'删除线',
            'pasteplain':'纯文本粘贴模式', 'preview':'预览',
            'removeformat':'清除格式'
        },
        //所有的的下拉框显示的内容
        listMap:{
            'fontfamily':['宋体', '楷体', '隶书', '黑体', 'andale mono', 'arial', 'arial black', 'comic sans ms', 'impact', 'times new roman'],
            'fontsize':[10, 11, 12, 14, 16, 18, 20, 24, 36],
            'paragraph':['p:段落', 'h1:标题 1', 'h2:标题 2', 'h3:标题 3', 'h4:标题 4', 'h5:标题 5', 'h6:标题 6'],
            'rowspacing':['5', '10', '15', '20', '25'],
            'lineheight':['1', '1.5','1.75','2', '3', '4', '5'],
            'customstyle':[
                {tag:'h1', label:'居中标题', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;text-align:center;margin:0 0 20px 0;'},
                {tag:'h1', label:'居左标题', style:'border-bottom:#ccc 2px solid;padding:0 4px 0 0;margin:0 0 10px 0;'},
                {tag:'span', label:'强调', style:'font-style:italic;font-weight:bold;color:#000'},
                {tag:'span', label:'明显强调', style:'font-style:italic;font-weight:bold;color:rgb(51, 153, 204)'}
            ]
        },
        //字体对应的style值
        fontMap:{
            '宋体':['宋体', 'SimSun'],
            '楷体':['楷体', '楷体_GB2312', 'SimKai'],
            '黑体':['黑体', 'SimHei'],
            '隶书':['隶书', 'SimLi'],
            'andale mono':['andale mono'],
            'arial':['arial', 'helvetica', 'sans-serif'],
            'arial black':['arial black', 'avant garde'],
            'comic sans ms':['comic sans ms'],
            'impact':['impact', 'chicago'],
            'times new roman':['times new roman']
        },
        //定义了右键菜单的内容
        
        initialStyle://编辑器内部样式
        //选中的td上的样式
        '.selectTdClass{background-color:#3399FF !important}' +
        //插入的表格的默认样式
        'table{clear:both;margin-bottom:10px;border-collapse:collapse;word-break:break-all;}' +
        //分页符的样式
        '.pagebreak{display:block;clear:both !important;cursor:default !important;width: 100% !important;margin:0;}' +
        //锚点的样式,注意这里背景图的路径
        //设置四周的留边
        '.view{padding:0;word-wrap:break-word;word-break:break-all;cursor:text;height:100%;}\n' +
        'body{margin:8px;font-family:"宋体";font-size:16px;}' +
        //针对li的处理
        'li{clear:both}' +
        //设置段落间距
        'p{margin:5px 0;}',
        initialContent:'输入日志内容',
        autoClearinitialContent:false, //是否自动清除编辑器初始内容，注意：如果focus属性设置为true,这个也为真，那么编辑器一上来就会触发导致初始化的内容看不到了
        removeFormatTags:'b,big,code,del,dfn,em,font,i,ins,kbd,q,samp,small,span,strike,strong,sub,sup,tt,u,var', //清除格式删除的标签
        removeFormatAttributes:'class,style,lang,width,height,align,hspace,valign', //清除格式删除的属性
        enterTag:'p', //编辑器回车标签。p或br
        maxUndoCount:20, //最多可以回退的次数
        maxInputCount:20, //当输入的字符数超过该值时，保存一次现场
        selectedTdClass:'selectTdClass', //设定选中td的样式名称
        pasteplain:false, //是否纯文本粘贴。false为不使用纯文本粘贴，true为使用纯文本粘贴
        textarea:'editorValue',
        focus:false, //初始化时，是否让编辑器获得焦点true或false
        indentValue:'2em', //初始化时，首行缩进距离
        pageBreakTag:'_baidu_page_break_tag_', //分页符
        minFrameHeight:320, //最小高度
        autoHeightEnabled:true, //是否自动长高
        maximumWords:10000, //允许的最大字符数
        tabSize:4, //tab的宽度
        tabNode:'&nbsp;', //tab时的单一字符
        tdHeight:'20', //单元格的默认高度
        wordCount: true,
        highlightJsUrl:"/assets/shCore.js",
        highlightCssUrl:"/assets/shCoreDefault.css",
        zIndex : 999, //编辑器z-index的基数
        fullscreen : false, //是否上来就是全屏
        messages:{
            pasteMsg:'编辑器已过滤掉您粘贴内容中不支持的格式！', //粘贴提示
            wordCountMsg:'当前已输入 {#count} 个字符，您还可以输入{#leave} 个字符 ', //字数统计提示，{#count}代表当前字数，{#leave}代表还可以输入多少字符数。
            wordOverFlowMsg:'你输入的字符个数已经超出最大允许值，服务器可能会拒绝保存！', //超出字数限制
            pasteWordImgMsg:'您粘贴的内容中包含本地图片，需要转存后才能正确显示！',
        },
        serialize:function () {                              //配置过滤标签
//            var X = baidu.editor.utils.extend;
//            var inline = {strong:1,em:1,b:1,i:1,u:1,span:1,a:1,img:1};
//            var block = X(inline, {p:1,div:1,blockquote:1,$:{style:1,dir:1}});
            return {
                //编辑器中不能够插入的标签，如果想插入那些标签可以去掉相应的标签名
                blackList:{style:1, link:1, object:1, applet:1, input:1, meta:1, base:1, button:1, select:1, textarea:1, '#comment':1, 'map':1, 'area':1}
//                whiteList: {
//                    div: X(block,{$:{style:1,'class':1}}),
//                    img: {$:{style:1,src:1,title:1,'data-imgref':1, 'data-refid':1, 'class':1}},
//                    a: X(inline, {$:{href:1}, a:0, sup:0}),
//                    strong: inline, em: inline, b: inline, i: inline,
//                    p: block,
//                    span: X(inline, {br:1,$:{style:1,id:1,highlight:1}}
//                }
            };
        }(),
        //下来框默认显示的内容
        ComboxInitial:{
            FONT_FAMILY:'字体',
            FONT_SIZE:'字号',
            PARAGRAPH:'段落格式',
            CUSTOMSTYLE:'自定义样式'
        },
        //自动排版参数
        autotypeset:{
            mergeEmptyline : true,          //合并空行
            removeClass : true,            //去掉冗余的class
            removeEmptyline : false,        //去掉空行
            textAlign : "left",             //段落的排版方式，可以是 left,right,center,justify 去掉这个属性表示不执行排版
            imageBlockLine : 'center',      //图片的浮动方式，独占一行剧中,左右浮动，默认: center,left,right,none 去掉这个属性表示不执行排版
            pasteFilter : false,             //根据规则过滤没事粘贴进来的内容
            clearFontSize : false,           //去掉所有的内嵌字号，使用编辑器默认的字号
            clearFontFamily : false,         //去掉所有的内嵌字体，使用编辑器默认的字体
            removeEmptyNode : false,         // 去掉空节点
            //可以去掉的标签
            removeTagNames : {div:1,a:1,abbr:1,acronym:1,address:1,b:1,bdo:1,big:1,cite:1,code:1,del:1,dfn:1,em:1,font:1,i:1,ins:1,label:1,kbd:1,q:1,s:1,samp:1,small:1,span:1,strike:1,strong:1,sub:1,sup:1,tt:1,u:1,'var':1},
            indent : false,                  // 行首缩进
            indentValue : '2em'             //行首缩进的大小
        }
    };
})();
