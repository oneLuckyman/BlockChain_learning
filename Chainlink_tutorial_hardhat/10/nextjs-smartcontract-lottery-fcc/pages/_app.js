import '@/styles/globals.css'
import { MoralisProvider } from 'react-moralis'

function Myapp({ Component, pageProps }) {
  return (
    <MoralisProvider initializeOnMount={false}>
      <Component {...pageProps} />
    </MoralisProvider>
}

export default Myapp