<item>

<a href={ opts.url }>
  <span class="language">{ opts.language }</span>
  { opts.title }
</a>

<style>
  item {
    display: block;
    text-align: left;
    border-bottom: 1px dotted #ddd;
    background: white;
  }
  item .language {
    background: #FB1C1C;
    color: white;
    text-align: center;
    width: 2em;
    line-height: 1.4em;
    border-radius: .6em;
    margin-right: .4em;
    display: inline-block;
    font-size: 80%;
  }
  item a {
    text-decoration: none;
    display: block;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    line-height: 2em;
    padding: .3em 5%;
    color: inherit;
  }
  item a:hover {
    background: #f7f7f7;
    color: #333;
  }
</style>

</item>
