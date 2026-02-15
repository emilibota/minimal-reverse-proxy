# Caddy Reverse Proxy → Cloudflare Worker (Render-ready)

Minimal Docker image running Caddy as a reverse proxy in front of a Cloudflare Worker.  
Designed for deployment on Render as a Docker Web Service.

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

--

## Deploying on Render

1. Create a new **Web Service**
2. Select **Docker** > **Public Repository**
3. Copy this repo's URL there
3. Add environment variables:
   - `SERVER_NAME`
   - `WORKER_HOST`
4. Click on Deploy
5. Set a custom domain in **Settings**
6. Set it in your domain's DNS records, in a CNAME record.

Render handles HTTPS at the edge.  
Caddy runs HTTP internally on `$PORT`.


## Optional: Path Prefix Proxying

Example: Forward only `/api/*` and strip `/api` before sending to the Worker:

```
:{$PORT} {
  handle_path /api/* {
    reverse_proxy https://{$WORKER_HOST} {
      header_up Host {$WORKER_HOST}
    }
  }
}
```

---

## Notes

- No TLS configuration required inside the container.
- No certificate management required.
- Keep the repository public for simplest deployment.
- Works with both `workers.dev` and custom Worker domains.
