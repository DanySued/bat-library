import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { Toaster } from 'sonner'
import './index.css'
import App from './App'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter>
      <App />
      <Toaster
        theme="dark"
        position="bottom-right"
        toastOptions={{
          style: {
            background: '#211C18',
            border: '1px solid #3D3028',
            color: '#D4CCC4',
            fontFamily: "'Lora', Georgia, serif",
            fontSize: '14px',
          },
        }}
      />
    </BrowserRouter>
  </StrictMode>
)
