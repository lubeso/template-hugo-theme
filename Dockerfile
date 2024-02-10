# syntax=docker/dockerfile:1


FROM bitnami/git:2.43.1 AS base

WORKDIR /src

RUN <<EOR
git clone 'https://github.com/lubeso/template-hugo-site.git' site

cat << EOF >> site/hugo.yaml
  imports:
  - path: /src/site/themes/custom
EOF
EOR


FROM betterweb/hugo:extended-0.121.1-20-1 AS dependencies

WORKDIR /src/site

COPY --from=base /src/site .

COPY . themes/custom

RUN <<EOF
corepack enable
corepack prepare pnpm@8.15.1 --activate
pnpm install
EOF


FROM dependencies AS server

EXPOSE 1313

ENTRYPOINT ["hugo"]

CMD ["serve", "--buildDrafts", "--bind", "0.0.0.0"]
