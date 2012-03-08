document.observe('never', function() {
    $$('.docs').invoke('hide');
    var apis = [];
    $$('#apis>li').each(function(el) {
      apis.push(el.remove());
    });
    apis.shuffle();
    apis.each(function(el) {
      $('apis').insert(el);
    });
    $$('article>ul>li').each(function(el) {
        var hue = Math.floor(Math.random() * 360);
        el.down('a').setStyle({backgroundColor: 'hsl(' + hue + ',100%,40%)'});
        el.down('.details').setStyle({backgroundColor: 'hsl(' + hue + ',20%,10%', borderBottomColor: 'hsl(' + hue + ',100%,40%)'});
        if (el.down('.response')) el.down('.response').update(js_beautify(el.down('.response').innerHTML, { 'indent_size': 2 }));
        el.down('a').observe('click', function(ev) {
            var toggled = el.down('.docs').visible();
            $$('.docs').each(function(el) {
                if (el.visible()) el.slideUp();
            });
            if (!toggled) el.down('.docs').slideDown();
            ev.stop();
            return false;
        });
    });
    sh_highlightDocument();
});

var greenDreams = {
  initialize: function() {
    console.log('initializing');
    greenDreams.fetchApis();
  },
  fetchApis: function() {
    console.log('fetching apis');
    new Ajax.Request('apis.yml', {
       method: 'get',
       onSuccess: function(response) {
          greenDreams.loadApis(response);
          greenDreams.drawApis();
        }
    });
  },
  loadApis: function(response) {
    console.log(response.responseText);
    greenDreams.apis = $H(jsyaml.load(response.responseText));
  },
  drawApis: function() {
    console.log('drawing apis');
    greenDreams.apis.each(function(kv) {
      console.log('drawing api');
      var k = kv[0];
      var api = kv[1];
      var li = new Element('li', { 'id': k});
      var hue = Math.floor(Math.random() * 360);
      //if (el.down('.response')) el.down('.response').update(js_beautify(el.down('.response').innerHTML, { 'indent_size': 2 }));
      var mainA = new Element('a', { 'href': '#' }).update(api.action);
      mainA.setStyle({backgroundColor: 'hsl(' + hue + ',100%,40%)'});
      mainA.observe('click', function(ev) {
        var toggled = li.down('.docs').visible();
        $$('.docs').each(function(el) {
            if (el.visible()) el.slideUp();
        });
        if (!toggled) {
          greenDreams.loadResponse(k);
          li.down('.docs').slideDown();
        }
        ev.stop();
        return false;
      });
      li.insert(mainA);
      var docs = new Element('div', { 'class': 'docs' });
      docs.hide();
      var details = new Element('div', { 'class': 'details' });
      details.setStyle({backgroundColor: 'hsl(' + hue + ',20%,10%', borderBottomColor: 'hsl(' + hue + ',100%,40%)'});
      var meta = new Element('div', { 'class': 'meta' });
      var h2 = new Element('h2').update(api.name);
      meta.insert(h2);
      var ul = new Element('ul');
      var apiLi = new Element('li');
      var apiLink = new Element('a', { 'href': api.apiSite }).update('API site');
      apiLi.insert(apiLink);
      ul.insert(apiLi);
      var docsLi = new Element('li');
      var docsLink = new Element('a', { 'href': api.documentation }).update('Documentation');
      docsLi.insert(docsLink);
      ul.insert(docsLi);
      var keysLi = new Element('li');
      var keysLink = new Element('a', { 'href': api.keyRegistration }).update('API key registration');
      keysLi.insert(keysLink);
      ul.insert(keysLi);
      meta.insert(ul);
      details.insert(meta);
      var cycle = new Element('div', { 'class': 'cycle' });
      var h3 = new Element('h3').update('Request');
      cycle.insert(h3);
      var dl = new Element('dl', { 'class': 'request' });
      var methodDt = new Element('dt').update('Method');
      dl.insert(methodDt);
      var methodDd = new Element('dd', { 'class': 'method' }).update(api.method);
      dl.insert(methodDd);
      var locationDt = new Element('dt').update('Location');
      dl.insert(locationDt);
      var locationDd = new Element('dd', { 'class': 'location' }).update(api.location);
      dl.insert(locationDd);
      var paramsDt = new Element('dt').update('Params');
      dl.insert(paramsDt);
      var paramsDd = new Element('dd', { 'class': 'params' }).update(api.params.escapeHTML());
      dl.insert(paramsDd);
      cycle.insert(dl);
      h3 = new Element('h3').update('Response');
      cycle.insert(h3);
      var pre = new Element('pre', { 'class': 'response sh_javascript' }).update('TODO');
      cycle.insert(pre);
      details.insert(cycle);
      docs.insert(details);
      li.insert(docs);
      $('apis').insert(li);
    });
  },
  loadResponse: function(apiName) {
    var api = greenDreams.apis.get(apiName);
    if (!api.loaded) {
      var el = $(apiName);
      new Ajax.Request(api.location, {
          method: api.method,
          parameters: greenDreams.keyedParams(api.params, api.apiKey, api.apiUser),
          onCreate: function(request) { 
              request.transport.setRequestHeader = Prototype.emptyFunction; 
          },
          onLoading: function() {
            el.down('pre.response').addClassName('loading');
          },
          onSuccess: function(response) {
            el.down('pre.response').update(js_beautify(response.responseText, { 'indent_size': 2 }));
            sh_highlightDocument();
            el.down('pre.response').removeClassName('loading');
            api.loaded = true;
          },
          onFailure: function() {
            el.down('pre.response').update('Query failed');
            el.down('pre.response').removeClassName('loading');
          }
      });
    }
  },
  keyedParams: function(params, apiKey, apiUser) {
    console.log ('keying params ' + params + ' with [' + apiKey + '] and [' + apiUser + ']');
    if (apiKey) params = params.gsub('APIKEY', apiKey)
    if (apiUser) params = params.gsub('APIUSER', apiUser)
    return params;
  }
}

document.observe('dom:loaded', greenDreams.initialize)
