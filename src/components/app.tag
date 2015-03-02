<app>

  <style scoped>
    :scope {
      display: block;
      text-align: center;
      color: #666;
    }
    form {
      background: #72A7EE;
      padding: 0 2em 2em;
      margin-bottom: 1em;
    }
    input[type=search] {
      width: 100%;
      font-size: 2em;
      padding: .5em 0;
      text-align: center;
      outline: none;
      border: 0;
      border-radius: .2em;
      background-color: rgba(255,255,255,.7);
      transition: all .5s;
    }
    input[type=search]:hover,
    input[type=search]:focus {
      background-color: rgba(255,255,255,1);
      box-shadow: 0 1px 5px rgba(0,0,0,.3);
    }
    p {
      color: #ccc;
    }
  </style>

  <logo title={ opts.title } />
  <form>
    <input type="search" value={ keyword } onkeyup={ keyup } placeholder="search">
  </form>
  <item each={ filtered } url={ url } language={ language } title={ title } />
  <p if={ more }>and { count - MAX } more documents</p>
  <footnote urls={ opts.urls } />

  <script>
    MAX = 20

    init() {
      this.keyword  = ''
      this.items    = opts.items
      this.filtered = []
      this.count    = 0
      this.more     = false
      this.search()
    }
    keyup(e) {
      this.keyword  = e.target.value.trim().toLowerCase()
      this.search()
    }
    search() {
      filtered = this.items.filter(this.filter)
      this.count = filtered.length
      this.more = (filtered.length > MAX)
      this.filtered = filtered.slice(0, MAX)
    }
    filter(item) {
      return !this.keyword.length
        || item.id.replace(/\-\w\w$/, '').match(this.keyword)
    }

    this.init()
  </script>

</app>
