FROM binlei/hexo:0.1.6

RUN rm -rf ./source/*

COPY source ./source/

COPY _config.yml ./

# theme next

RUN git clone -b v0.4.0 https://github.com/iissnan/hexo-theme-next themes/next

RUN sed -i -e 's/landscape/next/g' _config.yml \
 && sed -i -e 's/#scheme/scheme/g' themes/next/_config.yml \
 && sed -i -e 's/\/tags/\/tags\//g' themes/next/_config.yml

# theme next

RUN rm -rf public \
 && hexo generate \
 && bash -c "/bin/cp -rf public/* /usr/share/nginx/html/"

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
