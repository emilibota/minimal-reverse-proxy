# Caddy Reverse Proxy → Cloudflare Worker


Minimal Docker image running Caddy as a reverse proxy in front of a Cloudflare Worker.
Designed for deployment on Render as a Docker Web Service.

---

## Why?
I have webpages to care for. Spanish webpages. 
At first, it was only some spanish ISPs that blocked Cloudflare IPs, nowadays is every. spanish. ISP.

I don't have words to express how much I despise this people and how greedy they are.

So I build this as a free (or cheap) workaround for people like me that can't have the wepage down on a weekend and don't have money to spare in infrastructure.

Now it only needs to point the principal CNAME to the proxy.webpage.com following the [hayahora.futbol](https://hayahora.futbol/) webpage (thanks guys!) and everything will run smoothly (theoretically).

---

## What It Does

- Listens on the port provided by Render (`$PORT`)
- Routes traffic for a specific hostname
- Proxies all requests to your Cloudflare Worker
- Preserves the correct `Host` header for Worker compatibility

---

## Required Environment Variables

Set these in Render:

- `WORKER_HOST` → your Worker domain (e.g. `myworker.username.workers.dev`)

Render automatically injects:

- `PORT`

---

## Deploying on Render

1. Create a new **Web Service**
2. Select **Docker** > **Public Repository**
3. Copy this repo's URL there
3. Add environment variable `WORKER_HOST`
4. Click on Deploy
5. Set a custom domain in **Settings**
6. Set it in your domain's DNS records, in a CNAME record.

---

## Notes

- No TLS configuration required inside the container.
- No certificate management required.
- Keep the repository public for simplest deployment.
- Works with both `workers.dev` and custom Worker domains.
