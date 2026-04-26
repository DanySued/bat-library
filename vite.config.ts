import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'
import { access, createReadStream, constants } from 'fs'
import { viteStaticCopy } from 'vite-plugin-static-copy'

export default defineConfig({
  plugins: [
    react(),
    {
      name: 'serve-bat-files',
      configureServer(server) {
        server.middlewares.use('/files', (req, res, next) => {
          const url = req.url?.split('?')[0] || '/'
          const filePath = resolve(process.cwd(), 'files', url.replace(/^\//, ''))
          const base = resolve(process.cwd(), 'files')
          if (!filePath.startsWith(base)) { next(); return }
          access(filePath, constants.F_OK, (err) => {
            if (err) { next(); return }
            createReadStream(filePath).pipe(res)
          })
        })
      }
    },
    viteStaticCopy({
      targets: [{ src: 'files', dest: '' }]
    })
  ],
  resolve: {
    alias: { '@': resolve(__dirname, './src') }
  }
})
